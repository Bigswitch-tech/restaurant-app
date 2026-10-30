import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/app_colors.dart';
import 'package:food_delivery_app/Pages/cart_page.dart';
import 'package:food_delivery_app/Pages/favorites_page.dart';
import 'package:food_delivery_app/Pages/home_2_page.dart';
import 'package:food_delivery_app/Pages/profile_page.dart';

class MyBottomNavBar extends StatefulWidget {
  const new({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {

 int _selectedIndex = 0;

void _navigateBottomBar(int index){
  setState(() {
    _selectedIndex = index;
  });
}

final List<Widget> _pages = [

Home2Page(),
FavoritesPage(),
CartPage(),
ProfilePage(),

];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:_pages[_selectedIndex],
         bottomNavigationBar:  BottomNavigationBar(
         backgroundColor: AppColors.latte,
         elevation: 15,
         onTap: _navigateBottomBar,
         currentIndex: _selectedIndex,
         unselectedItemColor: AppColors.mochaGrey,
         selectedItemColor: AppColors.chocolate,
         showUnselectedLabels: true,
         selectedLabelStyle: TextStyle(fontSize: 15, fontWeight: .bold),
         unselectedLabelStyle:TextStyle(fontSize: 14,),
      
          items: [
          
          BottomNavigationBarItem( 
            activeIcon: Icon(Icons.home) ,
            icon: Icon(Icons.home_outlined), label: 'Home'),
            
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.favorite),
            icon: Icon(Icons.favorite_outline), label: 'Favorites'),

          BottomNavigationBarItem(
            activeIcon: Icon(Icons.shopping_cart),
            icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),

          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline), label: 'Profile'),
        ]),
    );
  }
}