
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/background_color.dart';
import 'package:food_delivery_app/Components/buttons.dart';
import 'package:food_delivery_app/Components/text_feilds.dart';
import 'package:food_delivery_app/Models/user_model.dart';
import 'package:food_delivery_app/Providers/auth_provider.dart';
import 'package:food_delivery_app/Screens/Users/login_screen.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signupKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final adminCodeController = TextEditingController();

  String selectedRole = 'user';

  bool obscureText = true;
  bool isLoading = false;

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Future<void> submit() async {
    if (isLoading) return;

    if (!_signupKey.currentState!.validate()) return;

    final addedUser = UserModel(
      fullName: fullNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    setState(() {
      isLoading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(
        context,
        listen: false,
      );

      if (selectedRole == 'admin') {
        await authProvider.addUserAsAdmin(addedUser);
      } else {
        await authProvider.addUser(addedUser);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully! Please login.'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false,
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup failed: ${error.toString()}'),
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
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    adminCodeController.dispose();
    super.dispose();
  }

  Widget roleButton(String role, String label, IconData icon) {
    final isSelected = selectedRole == role;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedRole = role;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFB87945)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFB87945),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.black,
              ),
              const SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
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
      body: Form(
        key: _signupKey,
        child: BackgroundColor(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),

                Image.asset(
                  'lib/images/banner.png',
                  width: 250,
                  height: 200,
                ),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                    color: Colors.grey.shade300,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        const Text(
                          'Create an account and enjoy',
                          style: TextStyle(fontSize: 16),
                        ),

                        const Text(
                          'delicious meals, delivered to you.',
                          style: TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 20),

                        // FULL NAME

                        MyTextFeilds(
                          prefixIcon: const Icon(Icons.person_outline),
                          hintText: 'Full Name',
                          controller: fullNameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Full name is required';
                            }
                            return null;
                          },
                          obscureText: false,
                        ),

                        // EMAIL

                        MyTextFeilds(
                          prefixIcon: const Icon(Icons.email_outlined),
                          hintText: 'Email',
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
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
                          obscureText: false,
                        ),

                        // PASSWORD

                        MyTextFeilds(
                          keyboardType: TextInputType.number,
                          prefixIcon: const Icon(Icons.lock_outline),
                          hintText: 'Password',
                          controller: passwordController,
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

                            if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                              return 'Password must be exactly 6 digits';
                            }

                            return null;
                          },
                          obscureText: obscureText,
                        ),

                        // CONFIRM PASSWORD

                        MyTextFeilds(
                          keyboardType: TextInputType.number,
                          prefixIcon: const Icon(Icons.lock_outline),
                          hintText: 'Confirm Password',
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirm your password';
                            }

                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }

                            return null;
                          },
                          obscureText: obscureText,
                        ),

                        const SizedBox(height: 20),

                        // ACCOUNT TYPE

                        const Text(
                          'Register as',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              roleButton(
                                'user',
                                'User',
                                Icons.person_outline,
                              ),
                              const SizedBox(width: 15),
                              roleButton(
                                'admin',
                                'Admin',
                                Icons.admin_panel_settings_outlined,
                              ),
                            ],
                          ),
                        ),

                        // ADMIN CODE FIELD

                        if (selectedRole == 'admin')
                          MyTextFeilds(
                            prefixIcon: const Icon(Icons.vpn_key_outlined),
                            hintText: 'Admin Invitation Code',
                            controller: adminCodeController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Admin code is required';
                              }
                              return null;
                            },
                            obscureText: false,
                          ),

                        const SizedBox(height: 25),

                        // SIGNUP BUTTON

                        Buttons(
                          onTap: submit,
                          buttonText: isLoading
                              ? 'CREATING ACCOUNT...'
                              : 'CREATE ACCOUNT',
                        ),

                        const SizedBox(height: 20),

                        // LOGIN LINK

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account? '),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Color(0xFFB87945),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
