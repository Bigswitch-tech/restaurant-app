
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:food_delivery_app/Models/user_model.dart';

class AuthProvider with ChangeNotifier {
  String? token;
  String? userId;
  String? userRole;

  static const String apiKey =
      'AIzaSyBBeL8MRJGOkFxuE5_hZ-kUyOeR0qVrvUo';

  static const String databaseUrl =
      'https://good-food-app-b6f11-default-rtdb.firebaseio.com';

  bool get getToken => token != null;

  String? get getTokenValue => token;

  String? get getUserId => userId;

  String? get getUserRole => userRole;

  // USER REGISTRATION
  Future<void> addUser(UserModel addUser) async {
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBBeL8MRJGOkFxuE5_hZ-kUyOeR0qVrvUo',
    );

    final response = await http.post(
      url,
      body: json.encode({
        'email': addUser.email.trim(),
        'password': addUser.password,
        'returnSecureToken': true,
      }),
    );

    final responseBody = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(
        responseBody['error']['message'],
      );
    }

    final dburl = Uri.parse('$databaseUrl/User.json');

    await http.post(
      dburl,
      body: json.encode({
        'fullName': addUser.fullName.trim(),
        'email': addUser.email.trim(),
        'role': 'user',
        'uid': responseBody['localId'],
      }),
    );

    notifyListeners();
  }


  // TEMPORARY ADMIN REGISTRATION
  // Replace with secure invitation verification later.

  Future<void> addUserAsAdmin(UserModel addUser) async {
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBBeL8MRJGOkFxuE5_hZ-kUyOeR0qVrvUo',
    );

    final response = await http.post(
      url,
      body: json.encode({
        'email': addUser.email.trim(),
        'password': addUser.password,
        'returnSecureToken': true,
      }),
    );

    final responseBody = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(
        responseBody['error']['message'],
      );
    }

    final newUserId = responseBody['localId'];

    final dbUrl = Uri.parse(
      '$databaseUrl/User/$newUserId.json',
    );

    final dbResponse = await http.put(
      dbUrl,
      body: json.encode({
        'fullName': addUser.fullName.trim(),
        'email': addUser.email.trim(),
        'role': 'admin',
        'uid': newUserId,
      }),
    );

    if (dbResponse.statusCode != 200) {
      throw Exception('Admin profile could not be created.');
    }

    notifyListeners();
  }


  // LOGIN AND VERIFY ROLE
  Future<bool> _login(
    UserModel loginUser, {
    required String expectedRole,
  }) async {
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBBeL8MRJGOkFxuE5_hZ-kUyOeR0qVrvUo',
    );

    final response = await http.post(
      url,
      body: json.encode({
        'email': loginUser.email.trim(),
        'password': loginUser.password.trim(),
        'returnSecureToken': true,
      }),
    );

    final responseBody = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(
        responseBody['error']['message'],
      );
    }

    final newToken = responseBody['idToken'];
    final newUserId = responseBody['localId'];

    // FIND USER PROFILE IN DATABASE
    final profileUrl = Uri.parse(
      '$databaseUrl/User.json?auth=$newToken',
    );

    final profileResponse = await http.get(profileUrl);

    if (profileResponse.statusCode != 200) {
      throw Exception('Could not retrieve user profile.');
    }

    final profiles = json.decode(profileResponse.body);

    if (profiles is! Map) {
      throw Exception('User profile not found.');
    }

    Map? userProfile;

    for (final profile in profiles.values) {
      if (profile['uid'] == newUserId) {
        userProfile = profile;
        break;
      }
    }

    if (userProfile == null) {
      throw Exception('User profile not found.');
    }

    final actualRole = userProfile['role'];

    if (actualRole != expectedRole) {
      throw Exception(
        expectedRole == 'admin'
            ? 'This account is not an administrator.'
            : 'Please use the administrator login.',
      );
    }

    token = newToken;
    userId = newUserId;
    userRole = actualRole;

    notifyListeners();

    return true;
  }

  // NORMAL USER LOGIN
  Future<bool> loginUser(UserModel loginUser) {
    return _login(
      loginUser,
      expectedRole: 'user',
    );
  }

  // ADMIN LOGIN
  Future<bool> loginUserAsAdmin(UserModel loginUser) {
    return _login(
      loginUser,
      expectedRole: 'admin',
    );
  }

  // LOGOUT
  void signout() {
    token = null;
    userId = null;
    userRole = null;

    notifyListeners();
  }
}
