
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/Admin/stat_card.dart';
import 'package:food_delivery_app/Components/Admin/admin_action_card.dart';
import 'package:food_delivery_app/Components/Admin/recent_order_card.dart';
import 'package:food_delivery_app/Screens/Admin/add_food_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
           const Text(
  'Overview',
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
),

            //Over view section

 const SizedBox(height: 15),

        GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.3,
            children:const [
              StatCard(
                title: 'Total Orders',
                value: '120',
                icon: Icons.shopping_bag_outlined,
                color: Colors.green,
              ),
              StatCard(
                title: 'Pending Orders',
                value: '15',
                icon: Icons.pending_actions,
                color: Colors.orange,
              ),
              StatCard(
                title: 'Food Items',
                value: '35',
                icon: Icons.restaurant_menu,
                color: Colors.blue,
              ),
            ],
          ),


            const SizedBox(height: 30),

            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            //Quick Actions

            const SizedBox(height: 15),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.6,
              children: [
                AdminActionCard(
                  title: 'Add Food',
                  icon: Icons.add_circle_outline,
                  color: Colors.green,
                  onTap: () {
                    Navigator.push(
                      context,
                       MaterialPageRoute(
                        builder: (context) => const AddFoodScreen(),
                      ),
                    );
                  },
                ),

                const AdminActionCard(
                  title: 'Manage Foods',
                  icon: Icons.restaurant_menu,
                  color: Colors.green,
                ),

                const AdminActionCard(
                  title: 'Manage Orders',
                  icon: Icons.receipt_long,
                  color: Colors.orange,
                ),

                const AdminActionCard(
                  title: 'Categories',
                  icon: Icons.category_outlined,
                  color: Colors.blue,
                ),
              ],
            ),

            // Order monitoring

            const SizedBox(height: 15),

                const RecentOrderCard(
                  orderId: 'Order #1001',
                  customerName: 'John Doe',
                  amount: '₦12,500',
                  status: 'Pending',
                ),

                const RecentOrderCard(
                  orderId: 'Order #1002',
                  customerName: 'Mary James',
                  amount: '₦8,000',
                  status: 'Delivered',
                ),

                const RecentOrderCard(
                  orderId: 'Order #1003',
                  customerName: 'David Smith',
                  amount: '₦15,000',
                  status: 'Pending',
                ),

                //

          ],
        ),
      ),
    );
  }
}
