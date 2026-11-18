
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/app_colors.dart';
import 'package:food_delivery_app/Components/food_card.dart';
import '../Pages/food__detail_page.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/Providers/favorite_provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final TextEditingController searchController =
      TextEditingController();

  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
  ];

  final List<Map<String, dynamic>> meals = [
    {
      'name': 'Jollof Rice',
      'description': 'Smoky Nigerian jollof rice',
      'price': 4500,
      'category': 'Lunch',
      'rating': '4.8',
      'image':
          'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=600',
    },
    {
      'name': 'Grilled Chicken',
      'description': 'Juicy grilled chicken',
      'price': 6500,
      'category': 'Dinner',
      'rating': '4.9',
      'image':
          'https://images.unsplash.com/photo-1532550907401-a500c9a57435?w=600',
    },
    {
      'name': 'Pancakes',
      'description': 'Soft pancakes with syrup',
      'price': 3500,
      'category': 'Breakfast',
      'rating': '4.7',
      'image':
          'https://images.unsplash.com/photo-1528207776546-365bb710ee93?w=600',
    },
    {
      'name': 'Burger',
      'description': 'Classic beef burger',
      'price': 5000,
      'category': 'Lunch',
      'rating': '4.8',
      'image':
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600',
    },
  ];

  // FILTER MEALS
  List<Map<String, dynamic>> get filteredMeals {
    return meals.where((meal) {
      final matchesCategory =
          selectedCategory == 'All' ||
              meal['category'] == selectedCategory;

      final matchesSearch =
          meal['name'].toString().toLowerCase().contains(
                searchController.text.toLowerCase(),
              );

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.latte,

      body: SafeArea(
        child: CustomScrollView(
          slivers: [

            // PINNED HEADER
            SliverPersistentHeader(
              pinned: true,
              delegate: _HomeHeaderDelegate(),
            ),

            // SCROLLABLE HOME CONTENT
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // SEARCH BAR
                    TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for food...',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // PROMOTIONAL BANNER
                    Container(
                      height: 165,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.chocolate,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'SPECIAL OFFER',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                const Text(
                                  'Delicious meals,\nbetter prices!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'Order Now',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Icon(
                            Icons.restaurant,
                            size: 85,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // CATEGORIES
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      height: 42,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),

                        itemBuilder: (context, index) {
                          final category = categories[index];

                          final isSelected =
                              selectedCategory == category;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.chocolate
                                    : Colors.white,
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.mochaGrey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 28),

                    // POPULAR MEALS
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popular Meals',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          '${filteredMeals.length} meals',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // REUSABLE FOOD CARD GRID
                    GridView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      itemCount: filteredMeals.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.68,
                      ),

                      itemBuilder: (context, index) {
                        final meal = filteredMeals[index];

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

                          isFavorite: context
                              .watch<FavoriteProvider>()
                              .isFavorite(meal['name']),

                          // FAVORITE BUTTON
                          onFavoriteTap: () {
                            context
                                .read<FavoriteProvider>()
                                .toggleFavorite(meal);
                          },

                          // OPEN FOOD DETAILS
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FoodDetailPage(
                                  name: meal['name'],
                                  image: meal['image'],
                                  category: meal['category'],
                                  description: meal['description'],
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

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// PINNED HEADER DESIGN
class _HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 115;

  @override
  double get maxExtent => 115;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppColors.latte,

      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 12,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // GREETING AND NOTIFICATION
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              const Text(
                'Hello, Food Lover 👋',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.notifications_none,
                  size: 23,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // PINNED HEADING
          const Text(
            'What would you like to eat?',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(
    covariant _HomeHeaderDelegate oldDelegate,
  ) {
    return false;
  }
}
