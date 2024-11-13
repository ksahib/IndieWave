// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String email;
  final String name;
  final String token;
  final String image_url;

  UserModel({
    required this.email,
    required this.name,
    required this.token,
    this.image_url = "",
  });
  

  UserModel copyWith({
    String? email,
    String? name,
    String? token,
    String? image_url,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      token: token ?? this.token,
      image_url: image_url ?? this.image_url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'token': token,
      'image_url': image_url,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, [String? image = ""]) {
    return UserModel(
      email: map['email'] ?? "",
      name: map['name'] ?? "",
      token: map['token'] ?? "",
      image_url: map['image_url'] ?? image ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name, token: $token, image_url: $image_url)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.name == name &&
      other.token == token &&
      other.image_url == image_url;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      name.hashCode ^
      token.hashCode ^
      image_url.hashCode;
  }
}
