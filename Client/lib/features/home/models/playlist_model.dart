// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PlaylistModel {
  final String name;
  final String cover_pic;
  final String email;
  final String playlist_id;
  PlaylistModel({
    required this.name,
    required this.cover_pic,
    required this.email,
    required this.playlist_id,
  });

  PlaylistModel copyWith({
    String? name,
    String? cover_pic,
    String? email,
    String? playlist_id,
  }) {
    return PlaylistModel(
      name: name ?? this.name,
      cover_pic: cover_pic ?? this.cover_pic,
      email: email ?? this.email,
      playlist_id: playlist_id ?? this.playlist_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cover_pic': cover_pic,
      'email': email,
      'playlist_id': playlist_id,
    };
  }

  factory PlaylistModel.fromMap(Map<String, dynamic> map) {
    return PlaylistModel(
      name: map['name'] ?? '',
      cover_pic: map['cover_pic'] ?? '',
      email: map['email'] ?? '',
      playlist_id: map['playlist_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaylistModel.fromJson(String source) => PlaylistModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PlaylistModel(name: $name, cover_pic: $cover_pic, email: $email, playlist_id: $playlist_id)';
  }

  @override
  bool operator ==(covariant PlaylistModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.cover_pic == cover_pic &&
      other.email == email &&
      other.playlist_id == playlist_id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      cover_pic.hashCode ^
      email.hashCode ^
      playlist_id.hashCode;
  }
}
