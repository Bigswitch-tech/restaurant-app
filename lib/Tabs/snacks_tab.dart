import 'package:flutter/material.dart';

import 'package:food_delivery_app/Tabs/food__tile.dart';

class SnacksTab extends StatefulWidget {
 const SnacksTab ({super.key});

  @override
  State<SnacksTab> createState() => _SnacksTabState();
}

class _SnacksTabState extends State<SnacksTab> {
  
  List foodOnSale = [

    //[foodType, foodPrice, foodImage, foodSize]

    ["Jellof Rice", "25.0", "lib/images/afro_rice.jpg", "Big"],

    ["Spageti", "15.0", "lib/images/afro_rice.jpg", "Small"],

    ["Yam and Egg", "25.0", "lib/images/afro_yam.jpg", "Big"],

    ["Beans", "31.0", "lib/images/afro_beans.jpg", "Big"],
       
    
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(12),
      itemCount: foodOnSale.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1/1.5,
        crossAxisCount: 2), 
      itemBuilder: (context, index){
        return FoodTile(
        foodType:foodOnSale[index][0], 
        foodPrice: foodOnSale[index][1], 
        foodImage: foodOnSale[index][2], 
        foodSize: foodOnSale[index][3],
        );
      });
  }
}