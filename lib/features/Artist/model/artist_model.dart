// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ArtistModel {
  final String email;
  final String artist_name;
  final String about;
  final String token;
  final String image_url;

  ArtistModel({
    required this.email,
    required this.artist_name,
    required this.about,
    required this.token,
    required this.image_url,
  });

  
  


  ArtistModel copyWith({
    String? email,
    String? artist_name,
    String? about,
    String? token,
    String? image_url,
  }) {
    return ArtistModel(
      email: email ?? this.email,
      artist_name: artist_name ?? this.artist_name,
      about: about ?? this.about,
      token: token ?? this.token,
      image_url: image_url ?? this.image_url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'artist_name': artist_name,
      'about': about,
      'token': token,
      'image_url': image_url,
    };
  }

  factory ArtistModel.fromMap(Map<String, dynamic> map) {
    return ArtistModel(
      email: map['email'] ?? "",
      artist_name: map['artist_name'] ?? "",
      about: map['about'] ?? "",
      token: map['token'] ?? "",
      image_url: map['image_url'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ArtistModel.fromJson(String source) => ArtistModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ArtistModel(email: $email, artist_name: $artist_name, about: $about, token: $token, image_url: $image_url)';
  }

  @override
  bool operator ==(covariant ArtistModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.artist_name == artist_name &&
      other.about == about &&
      other.token == token &&
      other.image_url == image_url;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      artist_name.hashCode ^
      about.hashCode ^
      token.hashCode ^
      image_url.hashCode;
  }
}
