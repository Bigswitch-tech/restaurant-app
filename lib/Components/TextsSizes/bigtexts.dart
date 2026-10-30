import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/app_colors.dart';

class MyBigText extends StatelessWidget {
  
  final String bigText;
  final double? bidFontSize;

  const MyBigText ({super.key, required this.bigText, this.bidFontSize});
   

  @override
  Widget build(BuildContext context) {
    return Text(bigText, style: TextStyle(fontSize: bidFontSize, fontWeight: .bold, color: AppColors.chocolate),);
  }
}

