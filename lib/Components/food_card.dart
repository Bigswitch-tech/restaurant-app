
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/Providers/cart_provider.dart';

class FoodCard extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final String category;
  final double price;
  final double rating;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const FoodCard({
    super.key,
    required this.name,
    required this.image,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.network(
                        image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.fastfood, size: 40),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onFavoriteTap,
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.white,
                        child: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                          size: 19,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.chocolate,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 4),
                 
      
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      '₦${price.toStringAsFixed(0)}',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.chocolate,
      ),
    ),

    Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
          size: 15,
        ),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(fontSize: 12),
        ),
      ],
    ),
  ],
),

const SizedBox(height: 10),

// ADD TO CART BUTTON
SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    onPressed: () {
      context.read<CartProvider>().addToCart({
        'name': name,
        'image': image,
        'description': description,
        'category': category,
        'price': price,
        'rating': rating,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$name added to cart'),
          duration: const Duration(milliseconds: 360),
        ),
      );
    },
    icon: const Icon(Icons.add, size: 18),
    label: const Text('Add to Cart'),
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.chocolate,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
