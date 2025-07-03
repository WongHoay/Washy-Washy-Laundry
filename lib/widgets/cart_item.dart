import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String total;
  final String washer;
  final String dryer;
  final String fold;

  const CartItem({
    super.key,
    required this.total,
    required this.washer,
    required this.dryer,
    required this.fold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/background2.png'), // replace with your asset
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              'assets/imgcheckout.png',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total : $total',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text('Washer  : ', style: TextStyle(fontSize: 12)),
                  Text(washer, style: const TextStyle(fontSize: 12)),
                ],
              ),
              Row(
                children: [
                  const Text('Dryer     : ', style: TextStyle(fontSize: 12)),
                  Text(dryer, style: const TextStyle(fontSize: 12)),
                ],
              ),
              Row(
                children: [
                  const Text('Fold      : ', style: TextStyle(fontSize: 12)),
                  Text(fold, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
