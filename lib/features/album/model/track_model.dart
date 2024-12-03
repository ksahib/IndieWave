// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TrackModel {
  final String track_id;
  final String track_name;
  final String tag;
  final String length;
  final String track_url;
  final String album_id;
  TrackModel({
    required this.track_id,
    required this.track_name,
    required this.tag,
    required this.length,
    required this.track_url,
    required this.album_id,
  });

  TrackModel copyWith({
    String? track_id,
    String? track_name,
    String? tag,
    String? length,
    String? track_url,
    String? album_id,
  }) {
    return TrackModel(
      track_id: track_id ?? this.track_id,
      track_name: track_name ?? this.track_name,
      tag: tag ?? this.tag,
      length: length ?? this.length,
      track_url: track_url ?? this.track_url,
      album_id: album_id ?? this.album_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'track_id': track_id,
      'track_name': track_name,
      'tag': tag,
      'length': length,
      'track_url': track_url,
      'album_id': album_id,
    };
  }

  factory TrackModel.fromMap(Map<String, dynamic> map) {
    return TrackModel(
      track_id: map['track_id'] ?? '',
      track_name: map['track_name'] ?? '',
      tag: map['tag'] ?? '',
      length: map['length'] ?? '',
      track_url: map['track_url'] ?? '',
      album_id: map['album_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TrackModel.fromJson(String source) => TrackModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TrackModel(track_id: $track_id, track_name: $track_name, tag: $tag, length: $length, track_url: $track_url, album_id: $album_id)';
  }

  @override
  bool operator ==(covariant TrackModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.track_id == track_id &&
      other.track_name == track_name &&
      other.tag == tag &&
      other.length == length &&
      other.track_url == track_url &&
      other.album_id == album_id;
  }

  @override
  int get hashCode {
    return track_id.hashCode ^
      track_name.hashCode ^
      tag.hashCode ^
      length.hashCode ^
      track_url.hashCode ^
      album_id.hashCode;
  }
}
