// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  // private initial name
  String name;

  UserModel({
    this.name = "Hello Ziad",
  });

  void changeName(String name) async {
    this.name = name;
    notifyListeners();
  }
}
