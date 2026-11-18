
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/app_colors.dart';
import 'package:food_delivery_app/Pages/cart_page.dart';
import 'package:food_delivery_app/Pages/favorites_page.dart';
import 'package:food_delivery_app/Pages/home_page.dart';
import 'package:food_delivery_app/Pages/profile_page.dart';


class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() =>
      _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePageScreen(),
    FavoritesPage(),
    CartPage(),
    ProfilePage(),
  ];

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _navItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final isSelected = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => _navigateBottomBar(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(
            vertical: 9,
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.chocolate
                : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? activeIcon : icon,
                color: isSelected
                    ? Colors.white
                    : AppColors.mochaGrey,
                size: 23,
              ),

              const SizedBox(height: 5),

              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected
                      ? FontWeight.bold
                      : FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : AppColors.mochaGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: IndexedStack(
  index: _selectedIndex,
  children: _pages,
),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(
          12, 10, 12, 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.latte,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(22),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 15,
              offset: const Offset(0, -3),
            ),
          ],
        ),

        child: SafeArea(
          top: false,
          child: Row(
            children: [

              _navItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                label: 'Home',
                index: 0,
              ),

              _navItem(
                icon: Icons.favorite_border,
                activeIcon: Icons.favorite,
                label: 'Favorites',
                index: 1,
              ),

              _navItem(
                icon: Icons.shopping_cart_outlined,
                activeIcon: Icons.shopping_cart,
                label: 'Cart',
                index: 2,
              ),

              _navItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
                index: 3,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
