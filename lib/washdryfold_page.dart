import 'package:flutter/material.dart';
import 'package:washywashy_laundry/payment_page.dart';

class WashDryFoldPage extends StatelessWidget {
  const WashDryFoldPage({super.key});

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
          // handle navigation
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title & back button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Laundry Details',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 0.03,
                    ),
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

              // Washer
              const Text('Choose Washer Machine',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMachineCard('assets/imgwashmacine.png', '15 KG', 'RM 5'),
                  _buildMachineCard('assets/imgwashmacine.png', '20 KG', 'RM 7'),
                  _buildMachineCard('assets/imgwashmacine.png', '30 KG', 'RM 10'),
                ],
              ),

              const SizedBox(height: 20),

              // Dryer
              const Text('Choose Dry Machine',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMachineCard('assets/imgdrymachine.png', '15 KG', 'RM 5'),
                  _buildMachineCard('assets/imgdrymachine.png', '20 KG', 'RM 10'),
                  _buildMachineCard('assets/imgdrymachine.png', '30 KG', 'RM 15'),
                ],
              ),

              const SizedBox(height: 20),

              // Fold
              const Text('Choose Fold Service',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMachineCard('assets/imgfoldmachine.png', '15 KG', 'RM 10'),
                  _buildMachineCard('assets/imgfoldmachine.png', '20 KG', 'RM 20'),
                  _buildMachineCard('assets/imgfoldmachine.png', '30 KG', 'RM 30'),
                ],
              ),

              const SizedBox(height: 20),

              // Icons & labels
              _buildInfoRow('assets/imgwashmacine.png', 'WASHER'),
              _buildInfoRow('assets/imgdrymachine.png', 'DRYER'),
              _buildInfoRow('assets/imgfoldmachine.png', 'FOLD'),

              const SizedBox(height: 20),

              // Total
              Row(
                children: const [
                  Text(
                    'Total :',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'RM 0.00',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Add to cart + checkout
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
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMachineCard(String img, String label, String price) {
    return Container(
      width: 130,
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

  Widget _buildInfoRow(String iconPath, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Image.asset(iconPath, width: 40, height: 40),
          const SizedBox(width: 20),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
