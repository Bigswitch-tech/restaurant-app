
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/ButtomNav/my_bottom_navbar.dart';
import 'package:food_delivery_app/Screens/Admin/admin_dashboard_screen.dart';
import 'package:provider/provider.dart';

import 'package:food_delivery_app/Components/background_color.dart';
import 'package:food_delivery_app/Components/buttons.dart';
import 'package:food_delivery_app/Components/text_feilds.dart';
import 'package:food_delivery_app/Models/user_model.dart';
import 'package:food_delivery_app/Pages/home_page.dart';
import 'package:food_delivery_app/Providers/auth_provider.dart';
import 'package:food_delivery_app/Screens/Users/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscureText = true;
  bool isLoading = false;

  String selectedRole = 'user';

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Future<void> login() async {
    if (!_loginKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final user = UserModel(
        fullName: '',
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final authProvider = context.read<AuthProvider>();

      final success = selectedRole == 'admin'
          ? await authProvider.loginUserAsAdmin(user)
          : await authProvider.loginUser(user);

      if (!mounted) return;

      if (success) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => selectedRole == 'admin'
                ? const AdminDashboard()
                : const MyBottomNavBar(),
          ),
          (route) => false,
        );
      }
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString().replaceFirst('Exception: ', ''),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundColor(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _loginKey,
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  SizedBox(
                    height: 160,
                    width: 160,
                    child: Image.asset(
                      'lib/images/banner.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Login to continue enjoying delicious meals.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(35),
                      ),
                    ),

                    child: Column(
                      children: [
                        const Text(
                          'Login As',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 18),

                        Row(
                          children: [
                            Expanded(
                              child: _roleButton(
                                title: 'User',
                                icon: Icons.person_outline,
                                role: 'user',
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: _roleButton(
                                title: 'Admin',
                                icon: Icons.admin_panel_settings_outlined,
                                role: 'admin',
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // EMAIL
                        MyTextFeilds(
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                          ),
                          hintText: 'Email',
                          controller: emailController,
                          obscureText: false,

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }

                            final emailRegex = RegExp(
                              r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                            );

                            if (!emailRegex.hasMatch(value.trim())) {
                              return 'Enter a valid email';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 12),

                        // PASSWORD
                        MyTextFeilds(
                          keyboardType: TextInputType.number,
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                          ),

                          hintText: 'Password',
                          controller: passwordController,
                          obscureText: obscureText,

                          suffixIcon: IconButton(
                            onPressed: togglePasswordVisibility,
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility_outlined,
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }

                            if (value.length != 6) {
                              return 'Enter your 6-digit password';
                            }

                            if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                              return 'Password must contain 6 digits';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 12),

                        // SIGN UP
                        if (selectedRole == 'user')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(fontSize: 14),
                              ),

                              const SizedBox(width: 6),

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SignUpScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFB87945),
                                  ),
                                ),
                              ),
                            ],
                          ),

                        const SizedBox(height: 35),

                        // LOGIN BUTTON
                        SizedBox(
                          width: double.infinity,
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Buttons(
                                  onTap: login,
                                  buttonText: 'LOGIN',
                                ),
                        ),

                        const SizedBox(height: 35),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _roleButton({
    required String title,
    required IconData icon,
    required String role,
  }) {
    final isSelected = selectedRole == role;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
        });
      },

      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFB87945)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFB87945)
                : Colors.grey.shade400,
          ),
        ),

        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected
                  ? Colors.white
                  : Colors.black54,
            ),

            const SizedBox(height: 6),

            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Colors.white
                    : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
