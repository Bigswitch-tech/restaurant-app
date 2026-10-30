import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/app_colors.dart';

class MyMediumText extends StatelessWidget {
  
  final String midText;
  final FontWeight? midWeight;
  final double? midFontSize;

  const MyMediumText ({super.key, required this.midText, this.midWeight, this.midFontSize, });
   

  @override
  Widget build(BuildContext context) {
    return Text(midText, style: TextStyle(fontSize: midFontSize, fontWeight: midWeight, color: AppColors.chocolate),);
  }
}