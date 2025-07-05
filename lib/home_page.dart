import 'package:flutter/material.dart';
import 'package:washywashy_laundry/dry_page.dart';
import 'package:washywashy_laundry/wash_page.dart';
import 'package:washywashy_laundry/washdry_page.dart';
import 'package:washywashy_laundry/washdryfold_page.dart';
import 'package:washywashy_laundry/cart_page.dart';
import 'package:washywashy_laundry/userprofile.dart';
import 'package:washywashy_laundry/userhistory_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onBottomNavTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const UserProfilePage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const UserCartPage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const UserHistoryPage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ✅ Bottom Navigation Bar - properly wired to _onBottomNavTapped
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color(0xFF3C3F43),
        currentIndex: _selectedIndex, // ← Bind to state variable
        onTap: _onBottomNavTapped,   // ← Use the function you defined
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),

      // ✅ Page content
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/imglogo.png', width: 200, height: 200),
                  const SizedBox(width: 20),
                  const Text(
                    'Laundry Service',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A5078),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  _buildServiceCard(
                    context: context,
                    imagePath: 'assets/imgwashdry.png',
                    title: 'Wash + Dry',
                    page: const WashDryPage(),
                  ),
                  _buildServiceCard(
                    context: context,
                    imagePath: 'assets/imgfold.png',
                    title: 'Wash + Dry + Fold',
                    page: const WashDryFoldPage(),
                  ),
                  _buildServiceCard(
                    context: context,
                    imagePath: 'assets/imgwash.png',
                    title: 'Wash',
                    page: const WashPage(),
                  ),
                  _buildServiceCard(
                    context: context,
                    imagePath: 'assets/imgdry.png',
                    title: 'Dry',
                    page: const DryPage(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required BuildContext context,
    required String imagePath,
    required String title,
    required Widget page,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: 190,
        height: 170,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Image.asset(imagePath, width: 100, height: 100),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
