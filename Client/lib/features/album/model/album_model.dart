// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AlbumModel {
  final String album_id;
  final String name;
  final String cover_art;
  final String artist_name;
  AlbumModel({
    required this.album_id,
    required this.name,
    required this.cover_art,
    required this.artist_name,
  });

  AlbumModel copyWith({
    String? album_id,
    String? name,
    String? cover_art,
    String? artist_name,
  }) {
    return AlbumModel(
      album_id: album_id ?? this.album_id,
      name: name ?? this.name,
      cover_art: cover_art ?? this.cover_art,
      artist_name: artist_name ?? this.artist_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'album_id': album_id,
      'name': name,
      'cover_art': cover_art,
      'artist_name': artist_name,
    };
  }

  factory AlbumModel.fromMap(Map<String, dynamic> map) {
    return AlbumModel(
      album_id: map['album_id'] ?? "",
      name: map['name'] ?? "",
      cover_art: map['cover_art'] ?? "",
      artist_name: map['artist_name'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory AlbumModel.fromJson(String source) => AlbumModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AlbumModel(album_id: $album_id, name: $name, cover_art: $cover_art, artist_name: $artist_name)';
  }

  @override
  bool operator ==(covariant AlbumModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.album_id == album_id &&
      other.name == name &&
      other.cover_art == cover_art &&
      other.artist_name == artist_name;
  }

  @override
  int get hashCode {
    return album_id.hashCode ^
      name.hashCode ^
      cover_art.hashCode ^
      artist_name.hashCode;
  }
}
