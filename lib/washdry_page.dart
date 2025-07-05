import 'package:flutter/material.dart';
import 'package:washywashy_laundry/cart_page.dart';
import 'package:washywashy_laundry/payment_page.dart';
import 'package:washywashy_laundry/home_page.dart';
import 'package:washywashy_laundry/userhistory_page.dart';
import 'package:washywashy_laundry/userprofile.dart';
import 'package:firebase_database/firebase_database.dart';

class WashDryPage extends StatefulWidget {
  const WashDryPage({super.key});

  @override
  State<WashDryPage> createState() => _WashDryPageState();
}

class _WashDryPageState extends State<WashDryPage> {
  int _selectedIndex = 0;

  String? selectedWasherKg;
  String? selectedDryerKg;
  double washerPrice = 0.0;
  double dryerPrice = 0.0;

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

  void addToCart() {
    final cartRef = FirebaseDatabase.instance.ref().child('Cart');

    final cartItem = {
      'washer': selectedWasherKg ?? 'NONE',
      'dryer': selectedDryerKg ?? 'NONE',
      'fold': 'NONE',
      'total': 'RM ${getTotalPrice().toStringAsFixed(2)}',
    };

    cartRef.push().set(cartItem);
  }

  double getTotalPrice() {
    return washerPrice + dryerPrice;
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
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Laundry Details',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
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

              const Text('Choose Washer Machine', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMachineOption('15 KG', 'RM 5', 'washer'),
                  _buildMachineOption('20 KG', 'RM 7', 'washer'),
                  _buildMachineOption('30 KG', 'RM 10', 'washer'),
                ],
              ),
              const SizedBox(height: 20),

              const Text('Choose Dry Machine', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMachineOption('15 KG', 'RM 5', 'dryer'),
                  _buildMachineOption('20 KG', 'RM 10', 'dryer'),
                  _buildMachineOption('30 KG', 'RM 15', 'dryer'),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Image.asset('assets/imgwashmacine.png', width: 40, height: 40),
                  const SizedBox(width: 20),
                  const Text('WASHER', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Image.asset('assets/imgdrymachine.png', width: 45, height: 45),
                  const SizedBox(width: 20),
                  const Text('DRYER', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  const Text('Total :', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  Text(
                    'RM ${getTotalPrice().toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      addToCart();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Added to Cart")),
                      );
                    },
                    child: Image.asset('assets/imgaddtocart.png', width: 60, height: 60),
                  ),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
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
                        style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
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

  Widget _buildMachineOption(String kg, String price, String type) {
    final double priceValue = double.parse(price.replaceAll('RM ', ''));
    bool isSelected = (type == 'washer' && selectedWasherKg == kg) ||
        (type == 'dryer' && selectedDryerKg == kg);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (type == 'washer') {
            selectedWasherKg = kg;
            washerPrice = priceValue;
          } else {
            selectedDryerKg = kg;
            dryerPrice = priceValue;
          }
        });
      },
      child: Container(
        width: 150,
        height: 150,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade100 : Colors.white,
          border: Border.all(color: isSelected ? Colors.blue : Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              type == 'washer' ? 'assets/imgwashmacine.png' : 'assets/imgdrymachine.png',
              width: 60,
              height: 60,
            ),
            const SizedBox(height: 5),
            Text(
              kg,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF140435)),
            ),
            Text(
              price,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFC70A50)),
            ),
          ],
        ),
      ),
    );
  }
}
