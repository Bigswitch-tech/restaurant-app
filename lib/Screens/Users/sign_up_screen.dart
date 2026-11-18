
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

  static const chocolate = Color(0xFF603923);
  static const latte = Color.fromARGB(255, 169, 111, 44);
  static const mocha = Color(0xFFB87945);

  String selectedRole = 'user';
  bool obscureText = true;
  bool isLoading = false;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    adminCodeController.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (isLoading || !_signupKey.currentState!.validate()) return;

    final addedUser = UserModel(
      fullName: fullNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    setState(() => isLoading = true);

    try {
      final auth = Provider.of<AuthProvider>(
        context,
        listen: false,
      );

      if (selectedRole == 'admin') {
        await auth.addUserAsAdmin(addedUser);
      } else {
        await auth.addUser(addedUser);
      }

      if (!mounted) return;

      if (selectedRole == 'admin' &&
    adminCodeController.text.trim() != 'GFADMIN2026') {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Invalid admin invitation code'),
      backgroundColor: Colors.red,
    ),
  );
  return;
}

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully. Please sign in.'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
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
        setState(() => isLoading = false);
      }
    }
  }

  Widget roleOption({
    required String role,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final selected = selectedRole == role;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedRole = role;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            color: selected ? chocolate : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? chocolate : Colors.grey.shade300,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: selected ? Colors.white : chocolate,
                size: 25,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.white : chocolate,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: selected
                      ? Colors.white70
                      : Colors.grey.shade600,
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
      backgroundColor: latte,
      body: BackgroundColor(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 20,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Form(
                  key: _signupKey,
                  child: Column(
                    children: [
                      // HEADER

                      Image.asset(
                        'lib/images/banner.png',
                        width: 145,
                        height: 115,
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: chocolate,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        'Join us and enjoy delicious meals delivered to you.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),

                      const SizedBox(height: 25),

                      // FORM CARD

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Personal Information',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: chocolate,
                              ),
                            ),

                            const SizedBox(height: 12),

                            MyTextFeilds(
                              prefixIcon: const Icon(Icons.person_outline),
                              hintText: 'Full Name',
                              controller: fullNameController,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return 'Full name is required';
                                }
                                return null;
                              },
                              obscureText: false,
                            ),

                            MyTextFeilds(
                              prefixIcon: const Icon(Icons.email_outlined),
                              hintText: 'Email Address',
                              controller: emailController,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return 'Email is required';
                                }

                                if (!RegExp(
                                  r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                ).hasMatch(value.trim())) {
                                  return 'Enter a valid email';
                                }

                                return null;
                              },
                              obscureText: false,
                            ),

                            MyTextFeilds(
                              keyboardType: TextInputType.number,
                              prefixIcon: const Icon(Icons.lock_outline),
                              hintText: 'Password (6 digits)',
                              controller: passwordController,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                icon: Icon(
                                  obscureText
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }

                                if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                                  return 'Enter exactly 6 digits';
                                }

                                return null;
                              },
                              obscureText: obscureText,
                            ),

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

                            const SizedBox(height: 18),

                            const Text(
                              'Choose Account Type',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: chocolate,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Row(
                              children: [
                                roleOption(
                                  role: 'user',
                                  title: 'User',
                                  subtitle: 'Order delicious meals',
                                  icon: Icons.person_outline,
                                ),
                                const SizedBox(width: 12),
                                roleOption(
                                  role: 'admin',
                                  title: 'Admin',
                                  subtitle: 'Manage the food service',
                                  icon: Icons.admin_panel_settings_outlined,
                                ),
                              ],
                            ),

                            if (selectedRole == 'admin') ...[
                              const SizedBox(height: 15),

                              MyTextFeilds(
                                prefixIcon: const Icon(
                                  Icons.vpn_key_outlined,
                                ),
                                hintText: 'Admin Invitation Code',
                                controller: adminCodeController,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty) {
                                    return 'Admin code is required';
                                  }
                                  return null;
                                },
                                obscureText: false,
                              ),
                            ],

                            const SizedBox(height: 20),

                            SizedBox(
                              width: double.infinity,
                              child: Buttons(
                                onTap: submit,
                                buttonText: isLoading
                                    ? 'CREATING ACCOUNT...'
                                    : 'CREATE ACCOUNT',
                              ),
                            ),

                            const SizedBox(height: 20),

                            Center(
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account? ',
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 13,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        color: mocha,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'Good food. Great moments.',
                        style: TextStyle(
                          color: chocolate.withOpacity(0.65),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
