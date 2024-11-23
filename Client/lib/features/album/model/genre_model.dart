// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GenreModel {
  final String tag;
  final String description;
  GenreModel({
    required this.tag,
    required this.description,
  });

  GenreModel copyWith({
    String? tag,
    String? description,
  }) {
    return GenreModel(
      tag: tag ?? this.tag,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tag': tag,
      'description': description,
    };
  }

  factory GenreModel.fromMap(Map<String, dynamic> map) {
    return GenreModel(
      tag: map['tag'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GenreModel.fromJson(String source) => GenreModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GenreModel(tag: $tag, description: $description)';

  @override
  bool operator ==(covariant GenreModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.tag == tag &&
      other.description == description;
  }

  @override
  int get hashCode => tag.hashCode ^ description.hashCode;
}
