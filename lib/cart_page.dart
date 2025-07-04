import 'package:flutter/material.dart';
import 'package:washywashy_laundry/userhistory_page.dart';
import 'package:washywashy_laundry/userprofile.dart';
import 'package:washywashy_laundry/widgets/cart_item.dart';
import 'package:washywashy_laundry/home_page.dart';

class UserCartPage extends StatefulWidget {
  const UserCartPage({super.key});

  @override
  State<UserCartPage> createState() => _UserCartPageState();
}


class _UserCartPageState extends State<UserCartPage> {

  int _selectedIndex = 2;

  void _onBottomNavTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const UserProfilePage()));
        break;
      case 2:
      // Already on Cart
        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const UserHistoryPage()));
        break;
    }
  }

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
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
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
