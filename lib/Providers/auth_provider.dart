import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class AuthProvider with ChangeNotifier{

   String? token;

  bool get getToken{
    return token != null;
  }

  void signout(){
  token = null;
  notifyListeners();
}
  

Future<void >addUser (UserModel addUser) async{

final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBBeL8MRJGOkFxuE5_hZ-kUyOeR0qVrvUo');

final _ = await http.post(url,
body: json.encode({

  'email': addUser.email,
  'password': addUser.password,
  'returnSecureToken': true,
}),);


final dburl = Uri.parse('https://good-food-app-b6f11-default-rtdb.firebaseio.com/User.json');

try{
  final _ = await http.post(dburl, 
body: json.encode({
  'fullName':addUser.fullName.trim(), 
  'email': addUser.email.trim(), 
  'password': addUser.password.trim(), })
  );
  
  }catch (error) {
      throw HttpException(error.toString(),);
    }
  notifyListeners();
}

Future <bool>loginUser (UserModel loginUser) async{

final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBBeL8MRJGOkFxuE5_hZ-kUyOeR0qVrvUo');

final response = await http.post(url,
body: json.encode({
 
    'email': loginUser.email.trim(), 
    'password': loginUser.password.trim(),
    'returnSecureToken': true,

    
})
);

final responseBody = json.decode(response.body);
if(responseBody['error'] != null) {
  throw Exception(responseBody ['error']['message']);
}

token = json.decode(response.body)['idToken'];
notifyListeners();


if (response.statusCode == 200) {
  print('Login successful!');
  return true;
} else {
  print('Login failed: ${response.body}');
  return false;
}
}


}
