import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final List<Map<String, String>>? selectedCartItems; // Nullable and optional
  const PaymentPage({super.key, this.selectedCartItems});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = '';

  double calculateTotal() {
    if (widget.selectedCartItems == null) return 0.0;

    double total = 0.0;
    for (var item in widget.selectedCartItems!) {
      final totalString = item['total']?.replaceAll('RM', '').trim();
      final amount = double.tryParse(totalString ?? '0') ?? 0.0;
      total += amount;
    }
    return total;
  }


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
          // Handle bottom nav tap
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Proceed to Payment',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 0.03,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Order Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...(widget.selectedCartItems?.isNotEmpty ?? false)
                  ? widget.selectedCartItems!.map((item) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOrderRow('assets/imgwashmacine.png', item['washer'] ?? 'NONE'),
                    _buildOrderRow('assets/imgdrymachine.png', item['dryer'] ?? 'NONE'),
                    _buildOrderRow('assets/imgfoldmachine.png', item['fold'] ?? 'NONE'),
                    const SizedBox(height: 10),
                  ],
                );
              }).toList()
                  : [
                _buildOrderRow('assets/imgwashmacine.png', 'NONE'),
                _buildOrderRow('assets/imgdrymachine.png', 'NONE'),
                _buildOrderRow('assets/imgfoldmachine.png', 'NONE'),
              ],
              const SizedBox(height: 20),
              Row(
                children:  [
                  Text(
                    'Total Amount :',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'RM ${calculateTotal().toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Select Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  _buildRadioOption('Credit Card'),
                  _buildRadioOption('Debit Card'),
                  _buildRadioOption('Online Banking'),
                  _buildRadioOption('Touch n Go'),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle payment confirmation
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6E9BB5),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Confirm Payment',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderRow(String imagePath, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Image.asset(imagePath, width: 40, height: 40),
          const SizedBox(width: 20),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRadioOption(String method) {
    return RadioListTile<String>(
      title: Text(method),
      value: method,
      groupValue: selectedPaymentMethod,
      onChanged: (value) {
        setState(() {
          selectedPaymentMethod = value!;
        });
      },
    );
  }
}
