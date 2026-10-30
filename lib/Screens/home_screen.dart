import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/app_colors.dart';
import 'package:food_delivery_app/Components/bottom_navbar.dart';

class HomePageScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {


 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: AppColors.white,
      
      bottomNavigationBar: MyBottomNavBar(),
      
      
    );
  }
}