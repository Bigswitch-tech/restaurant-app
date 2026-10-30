import 'package:flutter/material.dart';

class BackgroundColor extends StatelessWidget {
 

  final Widget child;

 const BackgroundColor ({super.key, required this.child});


  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter,
          colors: [
            Color(0xFFB87945),
            Color(0XFF603923),
            Color(0XFF30190F),
            Colors.black,
          ],
          stops: [0.1, 0.40, 0.75, 1.0],
          ),
      ),



      child: child,
    );
  }
}