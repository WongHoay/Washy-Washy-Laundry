import 'package:flutter/material.dart';
import 'package:washywashy_laundry/payment_page.dart';

class WashPage extends StatelessWidget {
  const WashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
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
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
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
                  const Text(
                    "WASHER",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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
                  const Text(
                    "RM 0.00",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/imgaddtocart.png', width: 60, height: 60),
                  ElevatedButton(
                    onPressed: () {
                      // Go to checkout
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PaymentPage()),
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
    return Container(
      width: 150,
      height: 150,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/imgwashmacine.png', width: 60, height: 60),
          const SizedBox(height: 5),
          Text(kg,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF140435))),
          Text(price,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFC70A50))),
        ],
      ),
    );
  }
}
