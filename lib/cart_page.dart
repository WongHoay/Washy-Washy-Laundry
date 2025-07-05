import 'package:flutter/material.dart';
import 'package:washywashy_laundry/userhistory_page.dart';
import 'package:washywashy_laundry/userprofile.dart';
import 'package:washywashy_laundry/widgets/cart_item.dart';
import 'package:washywashy_laundry/home_page.dart';

import 'package:firebase_database/firebase_database.dart';

class UserCartPage extends StatefulWidget {
  const UserCartPage({super.key});

  @override
  State<UserCartPage> createState() => _UserCartPageState();
}


class _UserCartPageState extends State<UserCartPage> {

  int _selectedIndex = 2;
  final List<Map<String, String>> cartItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  void fetchCartData() async {
    final dbRef = FirebaseDatabase.instance.ref().child('Cart');
    final snapshot = await dbRef.get();

    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      final List<Map<String, String>> loadedItems = [];

      data.forEach((key, value) {
        final item = Map<String, String>.from(value);
        loadedItems.add(item);
      });

      setState(() {
        cartItems.clear();
        cartItems.addAll(loadedItems);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }


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

    // final List<Map<String, String>> cartItems = [
    //   {
    //     'total': selectedDryerPrice ?? 'RM 0.00',
    //     'washer': 'NONE',
    //     'dryer': selectedDryerKg ?? 'NONE',
    //     'fold': 'NONE',
    //   },
    // ];

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
