import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/app_colors.dart';

class MyTabs extends StatelessWidget {

final IconData iconPath;
final String textT;

  const MyTabs({super.key, required this.iconPath, required this.textT});

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 35,
      child: Container(
        height: 80, width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.mochaGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Center(child: Text(textT, style: TextStyle(fontSize: 12, color: AppColors.background, fontWeight: .bold),)),
        ),
      ),
      );
  }
}