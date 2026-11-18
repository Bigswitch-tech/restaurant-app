import "dart:io";
import 'package:flutter/material.dart';
import "package:food_delivery_app/Models/food_model.dart";
import "package:http/http.dart" as http;
import "dart:convert";

class MealProvider with ChangeNotifier {
  String? userId;
  String? token;
  MealProvider(this.userId, this.token);

  Future<void> createMeal(FoodModel meal) async {
    final url = Uri.parse(
      "https://good-food-app-b6f11-default-rtdb.firebaseio.com/Meals.json?auth=$token");

    try {
      final response = await http.post(
        url,
        body: json.encode({
          "name": meal.foodName,
          "category": meal.id,
          "price": meal.foodPrice,
          "quantity": meal.foodQuantity,
          "Size": meal.foodSize,
          "image": meal.imageUrl,
          "created_at": DateTime.now().toIso8601String(),
          "user_id": userId,
        }),
      );

      final responseData = json.decode(response.body);
      print(responseData);
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<void> fetchMeals() async {
    final url = Uri.parse(
     "https://good-food-app-b6f11-default-rtdb.firebaseio.com/Meals.json?auth=$token",
     );
   

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      print(responseData);
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
