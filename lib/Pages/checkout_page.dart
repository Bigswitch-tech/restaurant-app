
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_delivery_app/Components/app_colors.dart';
import 'package:food_delivery_app/Providers/cart_provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
      TextEditingController();

  final TextEditingController _phoneController =
      TextEditingController();

  final TextEditingController _addressController =
      TextEditingController();

  final TextEditingController _instructionController =
      TextEditingController();

  String _paymentMethod = 'Cash on Delivery';

  // Temporary delivery fee. You can change this later.
  final double deliveryFee = 1500;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _instructionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    final subtotal = cart.subtotal;
    final total = subtotal + deliveryFee;

    return Scaffold(
      backgroundColor: AppColors.latte,

      appBar: AppBar(
        backgroundColor: AppColors.latte,
        elevation: 0,
        title: Text(
          'Checkout',
          style: TextStyle(
            color: AppColors.chocolate,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: cart.cartItems.isEmpty
          ? const Center(
              child: Text('Your cart is empty.'),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(18),

              child: Form(
                key: _formKey,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // DELIVERY INFORMATION
                    _sectionTitle('Delivery Information'),

                    const SizedBox(height: 15),

                    _textField(
                      controller: _nameController,
                      label: 'Full Name',
                      icon: Icons.person_outline,
                    ),

                    const SizedBox(height: 15),

                    _textField(
                      controller: _phoneController,
                      label: 'Phone Number',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(height: 15),

                    _textField(
                      controller: _addressController,
                      label: 'Delivery Address',
                      icon: Icons.location_on_outlined,
                      maxLines: 2,
                    ),

                    const SizedBox(height: 15),

                    _textField(
                      controller: _instructionController,
                      label: 'Delivery Instructions (Optional)',
                      icon: Icons.edit_note,
                      maxLines: 2,
                      required: false,
                    ),

                    const SizedBox(height: 28),

                    // ORDER SUMMARY
                    _sectionTitle('Order Summary'),

                    const SizedBox(height: 15),

                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),

                      child: Column(
                        children: [

                          ...cart.cartItems.map((meal) {
                            final price = double.parse(
                              meal['price'].toString(),
                            );

                            final quantity =
                                meal['quantity'] as int;

                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 15,
                              ),

                              child: Row(
                                children: [

                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(10),

                                    child: Image.network(
                                      meal['image'],
                                      width: 55,
                                      height: 55,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (_, __, ___) {
                                        return Container(
                                          width: 55,
                                          height: 55,
                                          color: AppColors.latte,
                                          child: const Icon(
                                            Icons.fastfood,
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [

                                        Text(
                                          meal['name'],
                                          style: TextStyle(
                                            color:
                                                AppColors.chocolate,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 5),

                                        Text(
                                          'Quantity: $quantity',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Text(
                                    '₦${(price * quantity).toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),

                          const Divider(),

                          _priceRow(
                            'Subtotal',
                            subtotal,
                          ),

                          const SizedBox(height: 12),

                          _priceRow(
                            'Delivery Fee',
                            deliveryFee,
                          ),

                          const Divider(height: 25),

                          _priceRow(
                            'Total',
                            total,
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // PAYMENT METHOD
                    _sectionTitle('Payment Method'),

                    const SizedBox(height: 15),

                    _paymentOption(
                      title: 'Cash on Delivery',
                      subtitle: 'Pay when your food arrives',
                      icon: Icons.payments_outlined,
                    ),

                    const SizedBox(height: 12),

                    _paymentOption(
                      title: 'Online Payment',
                      subtitle: 'Pay with your card or transfer',
                      icon: Icons.credit_card_outlined,
                    ),

                    const SizedBox(height: 30),

                    // PLACE ORDER BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton(
                        onPressed: _placeOrder,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.chocolate,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                        ),

                        child: Text(
                          'Place Order • ₦${total.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: AppColors.chocolate,
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    bool required = true,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,

      validator: (value) {
        if (required &&
            (value == null || value.trim().isEmpty)) {
          return 'Please enter your $label';
        }

        return null;
      },

      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: AppColors.mochaGrey,
        ),
        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(
            color: AppColors.chocolate,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _priceRow(
    String title,
    double amount, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Text(
          title,
          style: TextStyle(
            color: isTotal
                ? AppColors.chocolate
                : Colors.grey,
            fontWeight:
                isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 17 : 14,
          ),
        ),

        Text(
          '₦${amount.toStringAsFixed(0)}',
          style: TextStyle(
            color: AppColors.chocolate,
            fontWeight: FontWeight.bold,
            fontSize: isTotal ? 18 : 14,
          ),
        ),
      ],
    );
  }

  Widget _paymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = _paymentMethod == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          _paymentMethod = title;
        });
      },

      child: Container(
        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),

          border: Border.all(
            color: isSelected
                ? AppColors.chocolate
                : Colors.transparent,
            width: 1.5,
          ),
        ),

        child: Row(
          children: [

            Icon(
              icon,
              color: AppColors.chocolate,
              size: 25,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.chocolate,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: AppColors.chocolate,
            ),
          ],
        ),
      ),
    );
  }

  void _placeOrder() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Checkout details completed. Payment: $_paymentMethod',
        ),
        backgroundColor: AppColors.chocolate,
      ),
    );
  }
}
