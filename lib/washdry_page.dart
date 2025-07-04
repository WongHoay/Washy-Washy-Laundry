import 'package:flutter/material.dart';
import 'package:washywashy_laundry/cart_page.dart';
import 'package:washywashy_laundry/payment_page.dart';
import 'package:washywashy_laundry/home_page.dart';
import 'package:washywashy_laundry/userhistory_page.dart';
import 'package:washywashy_laundry/userprofile.dart';

class WashDryPage extends StatefulWidget {
  const WashDryPage({super.key});

  @override
  State<WashDryPage> createState() => _WashDryPageState();
}

class _WashDryPageState extends State<WashDryPage> {

  int _selectedIndex = 0;

  void _onNavTapped(int index) {
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const UserCartPage()));
        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const UserHistoryPage()));
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
        onTap: _onNavTapped,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Laundry Details',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.03,
                      color: Colors.black,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF2596BE),
                    radius: 18,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Text(
                'Choose Washer Machine',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMachineOption('assets/imgwashmacine.png', '15 KG', 'RM 5'),
                  _buildMachineOption('assets/imgwashmacine.png', '20 KG', 'RM 7'),
                  _buildMachineOption('assets/imgwashmacine.png', '30 KG', 'RM 10'),
                ],
              ),

              const SizedBox(height: 20),
              const Text(
                'Choose Dry Machine',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMachineOption('assets/imgdrymachine.png', '15 KG', 'RM 5'),
                  _buildMachineOption('assets/imgdrymachine.png', '20 KG', 'RM 10'),
                  _buildMachineOption('assets/imgdrymachine.png', '30 KG', 'RM 15'),
                ],
              ),

              const SizedBox(height: 20),
              Row(
                children: [
                  Image.asset('assets/imgwashmacine.png', width: 40, height: 40),
                  const SizedBox(width: 20),
                  const Text(
                    'WASHER',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Image.asset('assets/imgdrymachine.png', width: 45, height: 45),
                  const SizedBox(width: 20),
                  const Text(
                    'DRYER',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Row(
                children: const [
                  Text(
                    'Total :',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'RM 0.00',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/imgaddtocart.png', width: 60, height: 60),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle checkout
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PaymentPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA3C6DA),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMachineOption(String img, String label, String price) {
    return Container(
      width: 150,
      height: 150,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(img, width: 60, height: 60),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF140435),
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC70A50),
            ),
          ),
        ],
      ),
    );
  }
}