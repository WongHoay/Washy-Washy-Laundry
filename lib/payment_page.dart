import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:washywashy_laundry/paymentdetail_page.dart';

class PaymentPage extends StatefulWidget {
  final List<Map<String, String>>? selectedCartItems; // Nullable and optional
  final String washer;
  final String dryer;
  final String fold;
  final String total;

  const PaymentPage({
    super.key,
    this.selectedCartItems,
    required this.washer,
    required this.dryer,
    required this.fold,
    required this.total,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = '';

  String _generateOtp() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString(); // 6-digit OTP
  }
  double calculateTotal() {
    if (widget.selectedCartItems != null && widget.selectedCartItems!.isNotEmpty) {
      double total = 0.0;
      for (var item in widget.selectedCartItems!) {
        final totalString = item['total']?.replaceAll('RM', '').trim();
        final amount = double.tryParse(totalString ?? '0') ?? 0.0;
        total += amount;
      }
      return total;
    } else {
      // Fallback to individual prices passed from WashDryPage
      final totalString = widget.total.replaceAll('RM', '').trim();
      return double.tryParse(totalString) ?? 0.0;
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
                _buildOrderRow('assets/imgwashmacine.png', widget.washer),
                _buildOrderRow('assets/imgdrymachine.png', widget.dryer),
                _buildOrderRow('assets/imgfoldmachine.png', widget.fold),
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
                  onPressed: () async {
                    // Handle payment confirmation
                    if (selectedPaymentMethod.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a payment method')),
                      );
                      return;
                    }

                    final otp = _generateOtp();
                    final timestamp = DateTime.now().toString();
                    final user = FirebaseAuth.instance.currentUser;
                    final userId = user?.uid ?? 'unknown';

                    final historyRef = FirebaseDatabase.instance.ref().child('OrderHistory');
                    historyRef.push().set({
                      'otp': generatedOtp,
                      'washer': selectedWasherKg ?? 'NONE',
                      'dryer': selectedDryerKg ?? 'NONE',
                      'fold': 'NONE',
                      'total': 'RM ${getTotalPrice().toStringAsFixed(2)}',
                      'paymentMethod': selectedPaymentMethod,
                      'date': DateFormat('dd/MM/yyyy').format(DateTime.now()),
                    });

                    //.ref()
                        //.child('History')
                        //.push(); // auto-generate ID

                    final firstItem = widget.selectedCartItems?.isNotEmpty == true ? widget.selectedCartItems!.first : null;

                    final data = {
                      'washer': firstItem?['washer'] ?? widget.washer,
                      'dryer': firstItem?['dryer'] ?? widget.dryer,
                      'fold': firstItem?['fold'] ?? widget.fold,
                      'total': 'RM ${calculateTotal().toStringAsFixed(2)}',
                      'paymentMethod': selectedPaymentMethod,
                      'timestamp': timestamp,
                      'otp': otp,
                      'userId': userId,
                    };

                    await historyRef.set(data);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentDetailsPage(
                          washer: data['washer']!,
                          dryer: data['dryer']!,
                          fold: data['fold']!,
                          total: data['total']!,
                          paymentMethod: selectedPaymentMethod,
                          timestamp: timestamp,
                          otp: otp,
                        ),
                      ),
                    );
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
