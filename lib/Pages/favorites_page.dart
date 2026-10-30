import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/TextsSizes/bigtexts.dart';
import 'package:food_delivery_app/Components/TextsSizes/smalltexts.dart';
import 'package:food_delivery_app/Components/my_icons.dart';


class FavoritesPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(children: [
       SizedBox(height: 40,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyBigText(bigText: 'Favorites',bidFontSize: 20,),
                  MySmallText(smlText: 'Your go to meals, all in one place.'),
                ],
              ),
            ),
          
            MyIcons(boxShape:BoxShape.circle, padding: EdgeInsetsGeometry.symmetric(horizontal: 30, vertical: 0),
            child:Icon(Icons.favorite_outline), ),
          ],),
        ),      
       ],),
      );
  }
}