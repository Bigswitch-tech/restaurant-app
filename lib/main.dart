import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/ButtomNav/my_bottom_navbar.dart';
import 'package:food_delivery_app/Providers/auth_provider.dart';
import 'package:food_delivery_app/Providers/meal_provider.dart';
import 'package:food_delivery_app/Screens/Users/onborading_screen.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/Providers/favorite_provider.dart';
import 'package:food_delivery_app/Providers/cart_provider.dart';

void main() {
  runApp(MultiProvider(providers: [

        ChangeNotifierProxyProvider<AuthProvider, MealProvider>(
          create: (ctx) => MealProvider(null, null),
          update: (ctx, auth, previous) =>
              MealProvider(auth.getUserId, auth.getTokenValue),
        ),

           ChangeNotifierProvider(create: (_) => AuthProvider()),
           ChangeNotifierProvider(create: (_) => FavoriteProvider()),
           ChangeNotifierProvider(create: (_) => CartProvider()),
           
  ],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Resturant App',
     theme: ThemeData(primarySwatch: Colors.brown),
      home: 
      
      //const LoginScreen(),
      
      auth.getToken
    ? const MyBottomNavBar()
    : const OnboradingScreen(),
      
     
    );
      });
  }
}
