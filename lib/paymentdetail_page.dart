import 'package:flutter/material.dart';

class PaymentDetailsPage extends StatelessWidget {
  const PaymentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFE0F7FA),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          // Handle nav
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Wash
              Row(
                children: [
                  Image.asset('assets/imgwashmacine.png', width: 40, height: 40),
                  const SizedBox(width: 20),
                  const Text(
                    'NONE',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Dry
              Row(
                children: [
                  Image.asset('assets/imgdrymachine.png', width: 45, height: 45),
                  const SizedBox(width: 20),
                  const Text(
                    'NONE',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Fold
              Row(
                children: [
                  Image.asset('assets/imgfoldmachine.png', width: 40, height: 40),
                  const SizedBox(width: 20),
                  const Text(
                    'NONE',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Total Payment :',
                    style: TextStyle(color: Color(0xFF3B1B0D)),
                  ),
                  Text(
                    'RM 0.00',
                    style: TextStyle(color: Color(0xFF3B1B0D)),
                  ),
                ],
              ),

              // Method
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Method Payment :',
                    style: TextStyle(color: Color(0xFF3B1B0D)),
                  ),
                  Text(
                    'Touch n Go',
                    style: TextStyle(color: Color(0xFF3B1B0D)),
                  ),
                ],
              ),

              // Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Date :',
                    style: TextStyle(color: Color(0xFF3B1B0D)),
                  ),
                  Text(
                    '02/07/2025',
                    style: TextStyle(color: Color(0xFF3B1B0D)),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              const Center(
                child: Text(
                  'OTP FOR LAUNDRY MACHINE',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 0.03,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              const Center(
                child: Text(
                  '000 000',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE62B2B),
                    letterSpacing: 0.03,
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
