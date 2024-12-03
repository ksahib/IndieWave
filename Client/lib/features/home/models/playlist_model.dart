// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PlaylistModel {
  final String name;
  final String cover_pic;
  PlaylistModel({
    required this.name,
    required this.cover_pic,
  });

  PlaylistModel copyWith({
    String? name,
    String? cover_pic,
  }) {
    return PlaylistModel(
      name: name ?? this.name,
      cover_pic: cover_pic ?? this.cover_pic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cover_pic': cover_pic,
    };
  }

  factory PlaylistModel.fromMap(Map<String, dynamic> map) {
    return PlaylistModel(
      name: map['name'] ?? '',
      cover_pic: map['cover_pic'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaylistModel.fromJson(String source) => PlaylistModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PlaylistModel(name: $name, cover_pic: $cover_pic)';

  @override
  bool operator ==(covariant PlaylistModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.cover_pic == cover_pic;
  }

  @override
  int get hashCode => name.hashCode ^ cover_pic.hashCode;
}
