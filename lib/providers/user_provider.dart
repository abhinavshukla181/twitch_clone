import 'package:flutter/material.dart';
import 'package:twitch_clone/models/users.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(uid: '', username: '', email: '');

  User get user => _user;

  setUser(User user) {
    //it will recieve the usr from user model then it will set the global User to _user
    _user = user;
    notifyListeners();
  }
}
