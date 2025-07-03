import 'package:flutter/material.dart';

class OrderHistoryItem extends StatelessWidget {
  final String otp;
  final String washer;
  final String dryer;
  final String fold;

  const OrderHistoryItem({
    super.key,
    required this.otp,
    required this.washer,
    required this.dryer,
    required this.fold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        image: const DecorationImage(
          image: AssetImage('assets/background2.png'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/imglogo.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  otp,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text('Washer: ',
                        style: TextStyle(fontSize: 12, color: Colors.black)),
                    Text(washer,
                        style: const TextStyle(fontSize: 12, color: Colors.black)),
                  ],
                ),
                Row(
                  children: [
                    const Text('Dryer: ',
                        style: TextStyle(fontSize: 12, color: Colors.black)),
                    Text(dryer,
                        style: const TextStyle(fontSize: 12, color: Colors.black)),
                  ],
                ),
                Row(
                  children: [
                    const Text('Fold: ',
                        style: TextStyle(fontSize: 12, color: Colors.black)),
                    Text(fold,
                        style: const TextStyle(fontSize: 12, color: Colors.black)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
