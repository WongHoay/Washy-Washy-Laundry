import 'package:flutter/material.dart';
import 'package:washywashy_laundry/home_page.dart';
import 'package:washywashy_laundry/userprofile.dart';
import 'package:washywashy_laundry/userhistory_page.dart';
import 'package:washywashy_laundry/cart_page.dart';

class UserHistoryDetailsPage extends StatefulWidget {
  final String washer;
  final String dryer;
  final String fold;
  final String total;
  final String method;
  final String date;
  final String otp;

  const UserHistoryDetailsPage({
    super.key,
    required this.washer,
    required this.dryer,
    required this.fold,
    required this.total,
    required this.method,
    required this.date,
    required this.otp,
  });

  @override
  State<UserHistoryDetailsPage> createState() => _UserHistoryDetailsPageState();
}

class _UserHistoryDetailsPageState extends State<UserHistoryDetailsPage> {
  int _selectedIndex = 1; // History is selected

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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const UserHistoryPage()));
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const UserProfilePage()));
        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const UserCartPage()));
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
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Cart')
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Order Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Washer
              Row(
                children: [
                  Image.asset('assets/imgwashmacine.png', width: 40, height: 40),
                  const SizedBox(width: 20),
                  Text(
                    widget.washer,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),

              const SizedBox(height: 10),

              // Dryer
              Row(
                children: [
                  Image.asset('assets/imgdrymachine.png', width: 45, height: 45),
                  const SizedBox(width: 20),
                  Text(
                    widget.dryer,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),

              const SizedBox(height: 10),

              // Fold
              Row(
                children: [
                  Image.asset('assets/imgfoldmachine.png', width: 40, height: 40),
                  const SizedBox(width: 20),
                  Text(
                    widget.fold,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),

              const SizedBox(height: 20),

              // Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Payment:", style: TextStyle(color: Color(0xFF3B1B0D))),
                  Text(widget.total, style: const TextStyle(color: Color(0xFF3B1B0D))),
                ],
              ),

              // Method
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Method Payment:", style: TextStyle(color: Color(0xFF3B1B0D))),
                  Text(widget.method, style: const TextStyle(color: Color(0xFF3B1B0D))),
                ],
              ),

              // Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Date:", style: TextStyle(color: Color(0xFF3B1B0D))),
                  Text(widget.date, style: const TextStyle(color: Color(0xFF3B1B0D))),
                ],
              ),

              const SizedBox(height: 50),

              const Center(
                child: Text(
                  'OTP FOR YOUR MACHINE',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 0.03,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Center(
                child: Text(
                  widget.otp,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC70A50),
                    letterSpacing: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
