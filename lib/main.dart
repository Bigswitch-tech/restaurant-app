import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/app_colors.dart';
import 'package:food_delivery_app/Providers/auth_provider.dart';
import 'package:food_delivery_app/Screens/login_screen.dart';

import 'package:food_delivery_app/Screens/onborading_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MultiProvider(providers: [

    ChangeNotifierProvider(create: (_) => AuthProvider())
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
      home: auth.getToken ? LoginScreen() :  OnboradingScreen(),
      //AnimatedSplashScreen(),
     
    );
      });
  }
}
