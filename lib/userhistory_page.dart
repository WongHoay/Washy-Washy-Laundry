import 'package:flutter/material.dart';
import 'package:washywashy_laundry/cart_page.dart';
import 'package:washywashy_laundry/home_page.dart';
import 'package:washywashy_laundry/userprofile.dart';
import 'package:washywashy_laundry/widgets/order_history_item.dart';

class UserHistoryPage extends StatefulWidget {
  const UserHistoryPage({super.key});

  @override
  State<UserHistoryPage> createState() => _UserHistoryPageState();
}

class _UserHistoryPageState extends State<UserHistoryPage> {
  // Example data (replace with Firebase or local DB)
  final List<Map<String, String>> _history = const [
    {
      'otp': 'OTP: 234 567',
      'washer': '15 KG',
      'dryer': '20 KG',
      'fold': 'NONE',
    },
    {
      'otp': 'OTP: 887 112',
      'washer': '20 KG',
      'dryer': 'NONE',
      'fold': '15 KG',
    },
  ];

  int _selectedIndex = 3; // History index

  void _onBottomNavTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomePage()));
        break;
      case 1:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const UserProfilePage()));
        break;
      case 2:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const UserCartPage()));
        break;
      case 3:
      // Already on History
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFE0F7FA),
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
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'History',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 0.03,
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

              // History List
              // ListView.builder(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: _history.length,
              //   itemBuilder: (context, index) {
              //     final item = _history[index];
              //     return _buildHistoryItem(item);
              //   },
              // ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  final item = _history[index];
                  return OrderHistoryItem(
                    otp: item['otp'] ?? '',
                    washer: item['washer'] ?? 'NONE',
                    dryer: item['dryer'] ?? 'NONE',
                    fold: item['fold'] ?? 'NONE',
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

  Widget _buildHistoryItem(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        image: const DecorationImage(
          image: AssetImage('assets/background2.png'), // Replace with your background
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Date: ${item['date']}', style: const TextStyle(fontSize: 16)),
          Text('Service: ${item['service']}', style: const TextStyle(fontSize: 16)),
          Text('Total: ${item['total']}', style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
