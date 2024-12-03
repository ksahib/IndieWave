// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TrendModel {
  final String artist_name;
  final String about;
  final String profile_pic;
  final String track_id;
  final String track_name;
  final String track_url;
  final String album_id;
  final String album_name;
  final String album_cover;
  final int followers;
  final int likes;
  final int streams;
  TrendModel({
    required this.artist_name,
    required this.about,
    required this.profile_pic,
    required this.track_id,
    required this.track_name,
    required this.track_url,
    required this.album_id,
    required this.album_name,
    required this.album_cover,
    required this.followers,
    required this.likes,
    required this.streams,
  });

  TrendModel copyWith({
    String? artist_name,
    String? about,
    String? profile_pic,
    String? track_id,
    String? track_name,
    String? track_url,
    String? album_id,
    String? album_name,
    String? album_cover,
    int? followers,
    int? likes,
    int? streams,
  }) {
    return TrendModel(
      artist_name: artist_name ?? this.artist_name,
      about: about ?? this.about,
      profile_pic: profile_pic ?? this.profile_pic,
      track_id: track_id ?? this.track_id,
      track_name: track_name ?? this.track_name,
      track_url: track_url ?? this.track_url,
      album_id: album_id ?? this.album_id,
      album_name: album_name ?? this.album_name,
      album_cover: album_cover ?? this.album_cover,
      followers: followers ?? this.followers,
      likes: likes ?? this.likes,
      streams: streams ?? this.streams,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'artist_name': artist_name,
      'about': about,
      'profile_pic': profile_pic,
      'track_id': track_id,
      'track_name': track_name,
      'track_url': track_url,
      'album_id': album_id,
      'album_name': album_name,
      'album_cover': album_cover,
      'followers': followers,
      'likes': likes,
      'streams': streams,
    };
  }

  factory TrendModel.fromMap(Map<String, dynamic> map) {
    return TrendModel(
      artist_name: map['artist_name'] ?? '',
      about: map['about'] ?? '',
      profile_pic: map['profile_pic'] ?? '',
      track_id: map['track_id'] ?? '',
      track_name: map['track_name'] ?? '',
      track_url: map['track_url'] ?? '',
      album_id: map['album_id'] ?? '',
      album_name: map['album_name'] ?? '',
      album_cover: map['album_cover'] ?? '',
      followers: map['followers'] ?? 0,
      likes: map['likes'] ?? 0,
      streams: map['streams'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrendModel.fromJson(String source) => TrendModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TrendModel(artist_name: $artist_name, about: $about, profile_pic: $profile_pic, track_id: $track_id, track_name: $track_name, track_url: $track_url, album_id: $album_id, album_name: $album_name, album_cover: $album_cover, followers: $followers, likes: $likes, streams: $streams)';
  }

  @override
  bool operator ==(covariant TrendModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.artist_name == artist_name &&
      other.about == about &&
      other.profile_pic == profile_pic &&
      other.track_id == track_id &&
      other.track_name == track_name &&
      other.track_url == track_url &&
      other.album_id == album_id &&
      other.album_name == album_name &&
      other.album_cover == album_cover &&
      other.followers == followers &&
      other.likes == likes &&
      other.streams == streams;
  }

  @override
  int get hashCode {
    return artist_name.hashCode ^
      about.hashCode ^
      profile_pic.hashCode ^
      track_id.hashCode ^
      track_name.hashCode ^
      track_url.hashCode ^
      album_id.hashCode ^
      album_name.hashCode ^
      album_cover.hashCode ^
      followers.hashCode ^
      likes.hashCode ^
      streams.hashCode;
  }
}
