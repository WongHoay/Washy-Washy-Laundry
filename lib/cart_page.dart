import 'package:flutter/material.dart';
import 'package:washywashy_laundry/widgets/cart_item.dart';

class UserCartPage extends StatelessWidget {
  const UserCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Example cart data — replace with Firebase or Provider data
    final List<Map<String, String>> cartItems = [
      {
        'total': 'RM 10.00',
        'washer': '15 KG',
        'dryer': 'NONE',
        'fold': 'NONE',
      },
      {
        'total': 'RM 20.00',
        'washer': '20 KG',
        'dryer': '15 KG',
        'fold': 'NONE',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
        currentIndex: 2,
        onTap: (index) {
          // Handle bottom nav actions
        },
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'List Cart',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.03,
                      color: Colors.black,
                    ),
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFF2596BE),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, size: 20, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Cart List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return CartItem(
                    total: item['total']!,
                    washer: item['washer']!,
                    dryer: item['dryer']!,
                    fold: item['fold']!,
                  );
                },
              ),

              const SizedBox(height: 80), // Space for bottom nav
            ],
          ),
        ),
      ),
    );
  }
}
