import 'package:flutter/material.dart';

class MyTextFeilds extends StatelessWidget {

  final Widget prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final FormFieldSetter <String>? onSaved;
  final TextInputType? keyboardType;
  final bool obscureText;
  

   const MyTextFeilds ({super.key, required this.prefixIcon,
    this.suffixIcon, required this.hintText, this.controller, required this.validator, 
    this.onSaved, this.keyboardType, required this.obscureText,});
  

  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: TextFormField(
                
                obscureText: obscureText,
                keyboardType: keyboardType,
                onSaved: onSaved,
                validator: validator,
                controller: controller,
                decoration: InputDecoration(
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  hintText:hintText,
                  filled: true,
                  fillColor: Colors.white,
              
                
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(20)
                ),
              
                  focusedBorder: OutlineInputBorder(     
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(style: BorderStyle.solid, width: 1 )
                  )
                ),
              ),
            );
  }
}