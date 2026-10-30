import 'package:flutter/material.dart';


class Buttons extends StatelessWidget {
  

  final VoidCallback onTap;
  final String buttonText;

const Buttons ({super.key, required this.onTap, required this.buttonText, });

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(

              onTap:onTap,

              child: Container(
                height: 50, width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFFB87945),
                ),
                child:  Center(
                  child: Text(buttonText,
                                style: TextStyle(fontSize: 14,fontWeight: .bold, color: Colors.grey.shade100),),
                ),
              
              ),
            );
  }
}

class NavPage{

}