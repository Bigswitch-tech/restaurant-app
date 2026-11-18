
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_delivery_app/Components/app_colors.dart';
import 'package:food_delivery_app/Components/food_card.dart';
import '../Pages/food__detail_page.dart';
import 'package:food_delivery_app/Providers/favorite_provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteMeals =
        context.watch<FavoriteProvider>().favoriteMeals;

    return Scaffold(
      backgroundColor: AppColors.latte,

      appBar: AppBar(
        backgroundColor: AppColors.latte,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'My Favorites',
          style: TextStyle(
            color: AppColors.chocolate,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: favoriteMeals.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 75,
                    color: AppColors.mochaGrey,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'No favorites yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.chocolate,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your favorite meals will appear here.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${favoriteMeals.length} saved meals',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 15),

                  Expanded(
                    child: GridView.builder(
                      itemCount: favoriteMeals.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.68,
                      ),
                      itemBuilder: (context, index) {
                        final meal = favoriteMeals[index];

                        return FoodCard(
                          name: meal['name'],
                          image: meal['image'],
                          description: meal['description'],
                          category: meal['category'],
                          price: double.parse(
                            meal['price'].toString(),
                          ),
                          rating: double.parse(
                            meal['rating'].toString(),
                          ),
                          isFavorite: true,

                          onFavoriteTap: () {
                            context
                                .read<FavoriteProvider>()
                                .removeFavorite(meal['name']);
                          },

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FoodDetailPage(
                                  name: meal['name'],
                                  image: meal['image'],
                                  category: meal['category'],
                                  description:
                                      meal['description'],
                                  price: double.parse(
                                    meal['price'].toString(),
                                  ),
                                  rating: double.parse(
                                    meal['rating'].toString(),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
