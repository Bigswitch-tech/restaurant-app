import 'package:flutter/material.dart';


class MyIcons extends StatelessWidget {

final EdgeInsetsGeometry padding;
final BoxShape boxShape;
final Widget child;
final Color? addColor;

  const MyIcons ({super.key, required this.boxShape, required this.child, this.addColor, required this.padding});

  @override
  Widget build(BuildContext context) {
        return  Padding(
          padding: padding,
          child: Container(
          decoration: BoxDecoration(
            shape: boxShape, color: addColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            )));
}
}