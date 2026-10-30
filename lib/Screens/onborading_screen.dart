import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/background_color.dart';
import 'package:food_delivery_app/Components/buttons.dart';
import 'package:food_delivery_app/Screens/login_screen.dart';


class OnboradingScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<OnboradingScreen> createState() => _OnboradingScreenState();
}

class _OnboradingScreenState extends State<OnboradingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
      body:BackgroundColor(
        child: SafeArea(
          child: Column(
            children: [
            const SizedBox(height: 100),

            Image.asset('lib/images/banner.png'),

            const SizedBox(height: 70),

            Text('Meal planner', 
            style: TextStyle(fontSize: 20, color: Colors.grey.shade400),),

            Text('Fast Delivery', 
            style: TextStyle(fontSize: 33,fontWeight: .bold, color: Colors.grey.shade100),),

            Text('at your door step', 
            style: TextStyle(fontSize: 20, color: Colors.grey.shade400),),

            const SizedBox(height: 80),

            Buttons(
              
              onTap:(){ Navigator.pushReplacement(context, 
            PageRouteBuilder(pageBuilder: 
            (context, animation, secondaryAnimation){
              return LoginScreen();
            },
            transitionDuration: Duration.zero, 
            reverseTransitionDuration: Duration.zero,
             ),); }, 
            
            buttonText: 'GET STARTED')

           
            ],
          ))),
    );
  }
}