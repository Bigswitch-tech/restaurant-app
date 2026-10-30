

import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/TextsSizes/bigtexts.dart';
import 'package:food_delivery_app/Components/app_colors.dart';

class FoodTile extends StatelessWidget {

 

 final String  foodType;
 final String  foodPrice;
 final String  foodImage;
 final String  foodSize;


  const FoodTile ({super.key, required this.foodType, required this.foodPrice,
   required this.foodImage, required this.foodSize,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.latte
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

            //price

           Container(
            decoration: BoxDecoration(
              color: AppColors.mochaGrey,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),
                                              topRight: Radius.circular(12))
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('\$$foodPrice', style: TextStyle( color: Colors.white, fontWeight: .bold),),
            )),],),
           
            //picture
           
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 35,),
             child: Image.asset(foodImage,fit:BoxFit.fill,),
           ),

           SizedBox(height: 5,),

            //type

            MyBigText(bigText: foodType),

            SizedBox(height: 5,),

            //fav icon
            Container(
              width: 80, height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.white
              ),
              
                child: Center(child: MyBigText(bigText: foodSize,)),
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                Padding(
                  padding: const EdgeInsets.only( right: 8, left: 8),
                  child: Icon(Icons.favorite_outline),
                ),

                 Padding(
                  padding: const EdgeInsets.only( right: 8, left: 8),
                  child: Icon(Icons.add),
                ),
              ],)
          ],
        ),
      
      ),
    );
  }
}