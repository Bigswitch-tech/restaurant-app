import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/app_colors.dart';
import '../my_icons.dart';

class MyAppBars extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 130, leadingWidth: 70,
        backgroundColor: AppColors.mochaGrey,
        leading: Column(
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 30),
              child: CircleAvatar(backgroundColor: Colors.grey.shade100, radius: 40, child: Icon(Icons.person, size: 40, color: Colors.black,),),
            ),
          ],
        ),

         
        title: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Faizzah', style: TextStyle(fontWeight: .bold, fontSize: 20, color: AppColors.white),),
              SizedBox(height: 6,),
               Text('happyapp@gmail.com', style: TextStyle( fontSize: 16, color: AppColors.white),),
            ],
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 60, right: 5),
            child: MyIcons(boxShape: BoxShape.circle, 
            addColor: Colors.grey.shade100,
            padding:EdgeInsetsGeometry.all(8), 
            child: Icon(Icons.edit_note_outlined),),
          )
        ],
            
          );

  }
}