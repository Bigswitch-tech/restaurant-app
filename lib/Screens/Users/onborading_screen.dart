
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/background_color.dart';
import 'package:food_delivery_app/Components/buttons.dart';
import 'package:food_delivery_app/Screens/Users/login_screen.dart';

class OnboradingScreen extends StatelessWidget {
  const OnboradingScreen({super.key});

  static const Color chocolate = Color(0xFF603923);
  static const Color latte = Color(0xFFF7F0E8);
  static const Color mocha = Color(0xFFB87945);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundColor(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // TOP SECTION
                        Column(
                          children: [
                            const SizedBox(height: 15),

                            // APP NAME
                            const Text(
                              'GOOD FOOD',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 4,
                                color: chocolate,
                              ),
                            ),

                            const SizedBox(height: 35),

                            // FOOD BANNER
                            Image.asset(
                              'lib/images/banner.png',
                              height: 260,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),

                            const SizedBox(height: 35),

                            // SMALL LABEL
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: mocha.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Text(
                                'GOOD FOOD, GOOD MOOD',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  color: mocha,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // MAIN HEADING
                            const Text(
                              'Delicious Meals,',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: chocolate,
                                height: 1.2,
                              ),
                            ),

                            const Text(
                              'Delivered Fast.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: mocha,
                                height: 1.2,
                              ),
                            ),

                            const SizedBox(height: 15),

                            // DESCRIPTION
                            Text(
                              'Enjoy your favourite meals without the wait. '
                              'Freshly prepared and delivered right to your doorstep.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.6,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),

                        // BOTTOM SECTION
                        Column(
                          children: [
                            const SizedBox(height: 35),

                            Buttons(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LoginScreen(),
                                  ),
                                );
                              },
                              buttonText: 'GET STARTED',
                            ),

                            const SizedBox(height: 20),

                            Text(
                              'Good food is always a good idea.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                                fontStyle: FontStyle.italic,
                              ),
                            ),

                            const SizedBox(height: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
