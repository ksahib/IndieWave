// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PlaylistModel {
  final String name;
  final String cover_pic;
  final String email;
  PlaylistModel({
    required this.name,
    required this.cover_pic,
    required this.email,
  });

  PlaylistModel copyWith({
    String? name,
    String? cover_pic,
    String? email,
  }) {
    return PlaylistModel(
      name: name ?? this.name,
      cover_pic: cover_pic ?? this.cover_pic,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cover_pic': cover_pic,
      'email': email,
    };
  }

  factory PlaylistModel.fromMap(Map<String, dynamic> map) {
    return PlaylistModel(
      name: map['name'] ?? '',
      cover_pic: map['cover_pic'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaylistModel.fromJson(String source) => PlaylistModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PlaylistModel(name: $name, cover_pic: $cover_pic, email: $email)';

  @override
  bool operator ==(covariant PlaylistModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.cover_pic == cover_pic &&
      other.email == email;
  }

  @override
  int get hashCode => name.hashCode ^ cover_pic.hashCode ^ email.hashCode;
}
