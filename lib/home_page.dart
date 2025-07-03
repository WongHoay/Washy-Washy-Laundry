import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
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
                  _buildServiceCard(imagePath: 'assets/imgwashdry.png', title: 'Wash + Dry'),
                  _buildServiceCard(imagePath: 'assets/imgfold.png', title: 'Wash + Dry + Fold'),
                  _buildServiceCard(imagePath: 'assets/imgwash.png', title: 'Wash'),
                  _buildServiceCard(imagePath: 'assets/imgdry.png', title: 'Dry'),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard({required String imagePath, required String title}) {
    return Container(
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
    );
  }
}
