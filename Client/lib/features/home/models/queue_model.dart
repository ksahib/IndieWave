// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QueueModel {
  final String track_id;
  final String track_name;
  final String track_url;
  final String tag;
  final String cover_art;
  QueueModel({
    required this.track_id,
    required this.track_name,
    required this.track_url,
    required this.tag,
    required this.cover_art,
  });

  QueueModel copyWith({
    String? track_id,
    String? track_name,
    String? track_url,
    String? tag,
    String? cover_art,
  }) {
    return QueueModel(
      track_id: track_id ?? this.track_id,
      track_name: track_name ?? this.track_name,
      track_url: track_url ?? this.track_url,
      tag: tag ?? this.tag,
      cover_art: cover_art ?? this.cover_art,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'track_id': track_id,
      'track_name': track_name,
      'track_url': track_url,
      'tag': tag,
      'cover_art': cover_art,
    };
  }

  factory QueueModel.fromMap(Map<String, dynamic> map) {
    return QueueModel(
      track_id: map['track_id'] ?? '',
      track_name: map['track_name'] ?? '',
      track_url: map['track_url'] ?? '',
      tag: map['tag'] ?? '',
      cover_art: map['cover_art'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory QueueModel.fromJson(String source) => QueueModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QueueModel(track_id: $track_id, track_name: $track_name, track_url: $track_url, tag: $tag, cover_art: $cover_art)';
  }

  @override
  bool operator ==(covariant QueueModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.track_id == track_id &&
      other.track_name == track_name &&
      other.track_url == track_url &&
      other.tag == tag &&
      other.cover_art == cover_art;
  }

  @override
  int get hashCode {
    return track_id.hashCode ^
      track_name.hashCode ^
      track_url.hashCode ^
      tag.hashCode ^
      cover_art.hashCode;
  }
}
