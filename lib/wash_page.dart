import 'dart:math';
import 'package:flutter/material.dart';
import 'package:washywashy_laundry/cart_page.dart';
import 'package:washywashy_laundry/home_page.dart';
import 'package:washywashy_laundry/payment_page.dart';
import 'package:washywashy_laundry/userhistory_page.dart';
import 'package:washywashy_laundry/userprofile.dart';
import 'package:firebase_database/firebase_database.dart';

class WashPage extends StatefulWidget {
  const WashPage({super.key});

  @override
  State<WashPage> createState() => _WashPageState();
}

class _WashPageState extends State<WashPage> {
  String? selectedWasherKg;
  String? selectedWasherPrice;
  int _selectedIndex = 0;

  String generateOtp() {
    final random = Random();
    return '${random.nextInt(900) + 100} ${random.nextInt(900) + 100}';
  }

  void _onBottomNavTapped(int index) {
    if (index == _selectedIndex) return;

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

  void _addToCart() {
    if (selectedWasherKg == null || selectedWasherPrice == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a washer machine")),
      );
      return;
    }

    final dbRef = FirebaseDatabase.instance.ref().child('Cart');
    dbRef.push().set({
      'washer': selectedWasherKg!,
      'dryer': 'NONE',
      'fold': 'NONE',
      'total': selectedWasherPrice!,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Added to cart")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color(0xFF3C3F43),
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
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
                    "Laundry Details",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFF2596BE),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, size: 18, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choose Washer Machine",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildWashMachine("15 KG", "RM 5"),
                  _buildWashMachine("20 KG", "RM 10"),
                  _buildWashMachine("30 KG", "RM 15"),
                ],
              ),

              const SizedBox(height: 20),
              Row(
                children: [
                  Image.asset('assets/imgwashmacine.png', width: 45, height: 45),
                  const SizedBox(width: 10),
                  Text(
                    selectedWasherKg != null ? 'Washer: $selectedWasherKg ($selectedWasherPrice)' : 'WASHER',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  )
                ],
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  const Text(
                    "Total: ",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    selectedWasherPrice ?? "RM 0.00",
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _addToCart,
                    child: Image.asset('assets/imgaddtocart.png', width: 60, height: 60),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            washer: 'NONE',
                            dryer: selectedWasherKg ?? 'NONE',
                            fold: 'NONE',
                            total: selectedWasherPrice ?? 'RM 0.00',
                            paymentMethod: 'NONE', // or whatever method is selected
                            otp: generateOtp(), // create a method for this
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA3C6DA),
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                    ),
                    child: const Text(
                      "Checkout",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWashMachine(String kg, String price) {
    final bool isSelected = selectedWasherKg == kg;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedWasherKg = kg;
          selectedWasherPrice = price;
        });
      },
      child: Container(
        width: 150,
        height: 150,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade100 : Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/imgwashmacine.png', width: 60, height: 60),
            const SizedBox(height: 5),
            Text(kg, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF140435))),
            Text(price, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFC70A50))),
          ],
        ),
      ),
    );
  }
}
