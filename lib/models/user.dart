import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  const User({
    this.id,
    @required this.name,
    @required this.email,
    @required this.avatarUrl,
  });

  factory User.fromJson(String id, Map<String, dynamic> jsonData) {
    return User(
      id: id,
      name: jsonData['name'],
      email: jsonData['email'],
      avatarUrl: jsonData['avatarUrl'],
    );
  }

  static Map<String, dynamic> toMap(User user) =>
      {'name': user.name, 'email': user.email, 'avatarUrl': user.avatarUrl};
}
