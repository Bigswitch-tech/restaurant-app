import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/app_colors.dart';

class MySmallText extends StatelessWidget {
  
  final String smlText;
  final double? smalFontSize;

  const MySmallText ({super.key, required this.smlText, this.smalFontSize});
   

  @override
  Widget build(BuildContext context) {
    return Text(smlText, style: TextStyle(fontSize:smalFontSize, color: AppColors.mochaGrey),);
  }
}