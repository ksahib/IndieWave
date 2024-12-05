<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

require_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/vendor/autoload.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/trackModel.php';
include_once 'BaseController.php';

class Trending extends BaseController {
    
    public function _get() {
        $headers = apache_request_headers();
        $trendType = $headers['type'];

        try {
            if ($trendType == 'artist') {
                $query = "
                SELECT 
                    artist_name, 
                    album_id, 
                    track_id,
                    MAX(followers) AS followers,
                    MAX(likes) AS likes,
                    MAX(streams) AS streams
                FROM 
                    feed
                GROUP BY 
                    artist_name
                ORDER BY 
                    followers DESC, likes DESC, streams DESC
                LIMIT 10
                ";
            } else {
                $query = "
                SELECT 
                    * 
                FROM 
                    feed
                ORDER BY 
                    followers DESC, likes DESC, streams DESC
                LIMIT 30";
            }

            $stmt = $this->db->prepare($query);
            $stmt->execute();
            $feedResults = $stmt->fetchAll(PDO::FETCH_ASSOC);

            if (empty($feedResults)) {
                $this->sendResponse(401, 'No trend found');
                return;
            }

            $trendingData = [];
            foreach ($feedResults as $row) {
                $albumId = $row['album_id'];

                $albumQuery = "
                SELECT 
                    name, 
                    cover_art 
                FROM 
                    album 
                WHERE 
                    album_id = :album_id
                ";
                $albumStmt = $this->db->prepare($albumQuery);
                $albumStmt->bindParam(':album_id', $albumId);
                $albumStmt->execute();
                $albumData = $albumStmt->fetch(PDO::FETCH_ASSOC);

                $albumName = $albumData['name'] ?? 'Unknown Album';
                $imageId = $albumData['cover_art'] ?? null;

                $imageUrl = null;
                if ($imageId) {
                    $imageQuery = "
                    SELECT 
                        image_url 
                    FROM 
                        images 
                    WHERE 
                        image_id = :image_id
                    ";
                    $imageStmt = $this->db->prepare($imageQuery);
                    $imageStmt->bindParam(':image_id', $imageId);
                    $imageStmt->execute();
                    $imageData = $imageStmt->fetch(PDO::FETCH_ASSOC);
                    $imageUrl = $imageData['image_url'] ?? null;
                }

                $trackId = $row['track_id'];
                $trackQuery = "
                SELECT 
                    track_name, 
                    track_url 
                FROM 
                    tracks 
                WHERE  
                    track_id = :track_id
                ";
                $trackStmt = $this->db->prepare($trackQuery);
                $trackStmt->bindParam(':track_id', $trackId);
                $trackStmt->execute();
                $trackData = $trackStmt->fetch(PDO::FETCH_ASSOC);
                $trackName = $trackData['track_name'] ?? '';
                $trackUrl = $trackData['track_url'] ?? '';

                $artistName = $row['artist_name'];
                $artistQuery = "
                    SELECT 
                        profile_pic, 
                        about 
                    FROM 
                        artist 
                    WHERE 
                        artist_name = :artist_name
                    ";
                $artistStmt = $this->db->prepare($artistQuery);
                $artistStmt->bindParam(':artist_name', $artistName);
                $artistStmt->execute();
                $artistData = $artistStmt->fetch(PDO::FETCH_ASSOC);
                $profilePicId = $artistData['profile_pic'] ?? "";
                $about = $artistData['about'] ?? "";

                $profilePicQuery = "
                SELECT 
                    image_url 
                FROM 
                    images 
                WHERE 
                    image_id = :image_id
                ";
                $profilePicStmt = $this->db->prepare($profilePicQuery);
                $profilePicStmt->bindParam(':image_id', $profilePicId);
                $profilePicStmt->execute();
                $profilePicData = $profilePicStmt->fetch(PDO::FETCH_ASSOC);
                $profilePic = $profilePicData['image_url'] ?? "";

                $trendingData[] = [
                    'artist_name' => $row['artist_name'],
                    'about' => $about,
                    'profile_pic' => $profilePic,
                    'album_id' => $row['album_id'],
                    'album_name' => $albumName,
                    'album_cover' => $imageUrl,
                    'track_id' => $row['track_id'],
                    'track_name' => $trackName,
                    'track_url' => $trackUrl,
                    'followers' => $row['followers'],
                    'likes' => $row['likes'],
                    'streams' => $row['streams'],
                ];
            }

            $this->sendResponse(200, 'Retrieved trends', $trendingData);

        } catch (Exception $e) {
            $this->sendResponse(500, 'Internal server error: ' . $e->getMessage());
        }
    }
}
?>
