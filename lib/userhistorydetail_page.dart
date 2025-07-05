import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class UserHistoryDetailsPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // Mock data (replace with actual data or Firebase)
    const washer = '15 KG';
    const dryer = '20 KG';
    const fold = 'NONE';
    const total = 'RM 25.00';
    const method = 'Online Banking';
    const date = '03/07/2025';
    const otp = '783 211';

    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFE0F7FA),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          // Handle navigation here
        },
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
                    washer,
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
                    dryer,
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
                    fold,
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
                  Text(total, style: const TextStyle(color: Color(0xFF3B1B0D))),
                ],
              ),

              // Method
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Method Payment:", style: TextStyle(color: Color(0xFF3B1B0D))),
                  Text(method, style: const TextStyle(color: Color(0xFF3B1B0D))),
                ],
              ),

              // Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Date:", style: TextStyle(color: Color(0xFF3B1B0D))),
                  Text(date, style: const TextStyle(color: Color(0xFF3B1B0D))),
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
                  otp,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC70A50),
                    letterSpacing: 0.03,
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
