import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  static const _baseUrl = 'https://flutter-crud-e2fb7.firebaseio.com/';
  Map<String, User> _items = {};

  Future<void> setAll() async {
    final response = await http.get("$_baseUrl/users.json");

    final body = json.decode(response.body);

    body.forEach(
      (final String key, final value) {
        print(key);
        _items.putIfAbsent(key, () => User.fromJson(key, value));
      },
    );

    notifyListeners();
  }

  int get count {
    return _items.length;
  }

  User byIndex(int index) {
    return _items.values.elementAt(index);
  }

  Future<void> put(User user) async {
    if (user == null) {
      return;
    }

    print(user.id);

    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      await http.patch(
        "$_baseUrl/users/${user.id}.json",
        body: json.encode(User.toMap(user)),
      );

      _items.update(user.id, (_) => user);
    } else {
      final response = await http.post(
        "$_baseUrl/users.json",
        body: json.encode(User.toMap(user)),
      );

      final id = json.decode(response.body)['name'];

      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    }

    notifyListeners();
  }

  Future<void> remove(User user) async {
    if (user != null && user.id != null) {
      _items.remove(user.id);

      await http.delete(
        "$_baseUrl/users/${user.id}.json",
      );

      notifyListeners();
    }
  }
}
