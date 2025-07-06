import 'package:flutter/material.dart';
import 'package:washywashy_laundry/home_page.dart';
import 'package:washywashy_laundry/payment_page.dart';
import 'package:washywashy_laundry/userhistory_page.dart';
import 'package:washywashy_laundry/userprofile.dart';
import 'package:washywashy_laundry/cart_page.dart';
import 'package:firebase_database/firebase_database.dart';

class WashDryFoldPage extends StatefulWidget {
  const WashDryFoldPage({super.key});

  @override
  State<WashDryFoldPage> createState() => _WashDryFoldPageState();
}

class _WashDryFoldPageState extends State<WashDryFoldPage> {
  int _selectedIndex = 0;

  String? selectedWasherKg;
  String? selectedDryerKg;
  String? selectedFoldKg;

  double washerPrice = 0.0;
  double dryerPrice = 0.0;
  double foldPrice = 0.0;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() => _selectedIndex = index);

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
      'fold': selectedFoldKg ?? 'NONE',
      'total': 'RM ${getTotalPrice().toStringAsFixed(2)}',
    };

    cartRef.push().set(cartItem);
  }

  double getTotalPrice() => washerPrice + dryerPrice + foldPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color(0xFF3C3F43),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Laundry Details',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFF2596BE),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, size: 20, color: Colors.white),
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
                  _buildSelectableMachine('15 KG', 'RM 5', 'washer'),
                  _buildSelectableMachine('20 KG', 'RM 7', 'washer'),
                  _buildSelectableMachine('30 KG', 'RM 10', 'washer'),
                ],
              ),
              const SizedBox(height: 20),

              const Text('Choose Dry Machine', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSelectableMachine('15 KG', 'RM 5', 'dryer'),
                  _buildSelectableMachine('20 KG', 'RM 10', 'dryer'),
                  _buildSelectableMachine('30 KG', 'RM 15', 'dryer'),
                ],
              ),
              const SizedBox(height: 20),

              const Text('Choose Fold Service', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSelectableMachine('15 KG', 'RM 10', 'fold'),
                  _buildSelectableMachine('20 KG', 'RM 20', 'fold'),
                  _buildSelectableMachine('30 KG', 'RM 30', 'fold'),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Image.asset('assets/imgwashmacine.png', width: 40, height: 40),
                  const SizedBox(width: 20),
                  Text(
                    selectedWasherKg != null ? 'Washer: $selectedWasherKg ($washerPrice)' : 'WASHER',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Image.asset('assets/imgdrymachine.png', width: 45, height: 45),
                  const SizedBox(width: 20),
                  Text(
                    selectedDryerKg != null ? 'Dryer: $selectedDryerKg ($dryerPrice)' : 'DRYER',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Image.asset('assets/imgfoldmachine.png', width: 45, height: 45),
                  const SizedBox(width: 20),
                  Text(
                    selectedFoldKg != null ? 'Fold: $selectedFoldKg ($foldPrice)' : 'DRYER',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Total
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

              // Add to cart + checkout
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
                        Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => PaymentPage(
                                washer: selectedWasherKg ?? 'NONE',
                                dryer: selectedDryerKg ?? 'NONE',
                                fold: selectedFoldKg ?? 'NONE',
                                total: 'RM ${getTotalPrice().toStringAsFixed(2)}',
                                paymentMethod: 'NONE',
                                otp: '',
                              ),
                            ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA3C6DA),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectableMachine(String kg, String price, String type) {
    final double priceValue = double.parse(price.replaceAll('RM ', ''));
    bool isSelected = (type == 'washer' && selectedWasherKg == kg) ||
        (type == 'dryer' && selectedDryerKg == kg) ||
        (type == 'fold' && selectedFoldKg == kg);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (type == 'washer') {
            selectedWasherKg = kg;
            washerPrice = priceValue;
          } else if (type == 'dryer') {
            selectedDryerKg = kg;
            dryerPrice = priceValue;
          } else {
            selectedFoldKg = kg;
            foldPrice = priceValue;
          }
        });
      },
      child: Container(
        width: 130,
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
              type == 'washer'
                  ? 'assets/imgwashmacine.png'
                  : type == 'dryer'
                  ? 'assets/imgdrymachine.png'
                  : 'assets/imgfoldmachine.png',
              width: 60,
              height: 60,
            ),
            const SizedBox(height: 5),
            Text(kg, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF140435))),
            Text(price, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFC70A50))),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String iconPath, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Image.asset(iconPath, width: 40, height: 40),
          const SizedBox(width: 20),
          Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
        ],
      ),
    );
  }
}
