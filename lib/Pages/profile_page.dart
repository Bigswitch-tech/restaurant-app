
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/TextsSizes/bigtexts.dart';
import 'package:food_delivery_app/Components/TextsSizes/mediumtext.dart';
import 'package:food_delivery_app/Components/TextsSizes/smalltexts.dart';
import 'package:food_delivery_app/Components/app_colors.dart';
import 'package:food_delivery_app/Components/buttons.dart';
import 'package:food_delivery_app/Providers/auth_provider.dart';
import 'package:food_delivery_app/Screens/Users/login_screen.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  void _showDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return CupertinoAlertDialog(
          title: MyBigText(bigText: 'Want to sign out?'),
          content: MyMediumText(
            midText: 'Are you sure you want to log out?',
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),

            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                context.read<AuthProvider>().signout();

                Navigator.pop(dialogContext);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Yes, Sign Out'),
            ),
          ],
        );
      },
    );
  }

  Widget _profileOption({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 7,
        ),

        leading: Container(
          height: 43,
          width: 43,
          decoration: BoxDecoration(
            color: AppColors.latte,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.chocolate,
            size: 22,
          ),
        ),

        title: MyMediumText(midText: title),

        subtitle: MySmallText(smlText: subtitle),

        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: AppColors.mochaGrey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.latte,

      appBar: AppBar(
        backgroundColor: AppColors.latte,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: MyBigText(bigText: 'My Profile'),
        centerTitle: false,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // PROFILE HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: AppColors.mochaGrey,
                borderRadius: BorderRadius.circular(22),
              ),

              child: Row(
                children: [

                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person_rounded,
                      size: 45,
                      color: AppColors.chocolate,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          'Faizzah',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          'happyapp@gmail.com',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.white,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Food Lover',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      // Edit profile will be connected later.
                    },
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ACCOUNT SECTION
            MyBigText(bigText: 'My Account'),

            const SizedBox(height: 14),

            _profileOption(
              icon: Icons.shopping_bag_outlined,
              title: 'My Orders',
              subtitle: 'View your order history',
            ),

            _profileOption(
              icon: Icons.location_on_outlined,
              title: 'Saved Addresses',
              subtitle: 'Manage your delivery addresses',
            ),

            _profileOption(
              icon: Icons.payment_outlined,
              title: 'Payment Methods',
              subtitle: 'Manage your payment options',
            ),

            const SizedBox(height: 18),

            // PREFERENCES SECTION
            MyBigText(bigText: 'Preferences'),

            const SizedBox(height: 14),

            _profileOption(
              icon: Icons.notifications_none_rounded,
              title: 'Notifications',
              subtitle: 'Order updates and special offers',
            ),

            _profileOption(
              icon: Icons.support_agent_rounded,
              title: 'Help & Support',
              subtitle: 'Get help whenever you need it',
            ),

            _profileOption(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              subtitle: 'How we protect your information',
            ),

            _profileOption(
              icon: Icons.description_outlined,
              title: 'Terms & Conditions',
              subtitle: 'Read our terms of service',
            ),

            const SizedBox(height: 20),

            // LOGOUT
            SizedBox(
              width: double.infinity,
              child: Buttons(
                onTap: _showDialog,
                buttonText: 'Sign Out',
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Text(
                'Good Food App • Version 1.0.0',
                style: TextStyle(
                  color: AppColors.mochaGrey,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
