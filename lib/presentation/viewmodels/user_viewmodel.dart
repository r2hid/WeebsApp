import 'package:flutter/material.dart';
import 'package:wibu_app/data/sources/user_database_helper.dart';
import 'package:wibu_app/data/models/user_model.dart';

class UserViewModel extends ChangeNotifier {
  final UserDatabaseHelper _dbHelper = UserDatabaseHelper();
  User? _user;
  String? _error;
  List<User>? _allUsers;

  User? get user => _user;
  String? get error => _error;
  List<User>? get allUsers => _allUsers;

  Future<bool> register(String username, String password, {bool isAdmin = false}) async {
    try {
      bool isUsernameExists = await _dbHelper.isUsernameExists(username);

      if (isUsernameExists) {
        _error = 'Username already exists';
        notifyListeners();
        return false;
      } else {
        await _dbHelper.insertUser(User(username: username, password: password, isAdmin: isAdmin));
        _error = null;
        notifyListeners();
        return true;
      }
    } catch (e) {
      _error = 'Error registering user';
      notifyListeners();
      return false;
    }
  }

  Future<void> login(String username, String password) async {
    try {
      _user = await _dbHelper.getUser(username, password);
      if (_user == null) {
        _error = 'Invalid username or password';
      } else {
        _error = null;
      }
      notifyListeners();
    } catch (e) {
      _error = 'Error logging in';
      notifyListeners();
    }
  }

  Future<void> getAllUsers() async {
    try {
      _allUsers = await _dbHelper.getAllUsers();
      notifyListeners();
    } catch (e) {
      _error = 'Error fetching users';
      notifyListeners();
    }
  }

  void logout() {
    _user = null;
    _allUsers = null;
    _error = null;
    notifyListeners();
  }

  bool get isAdmin {
    return _user?.isAdmin ?? false;
  }
}