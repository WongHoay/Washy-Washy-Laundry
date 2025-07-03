// import 'package:flutter/material.dart';
//
// // Example cart item model
// class CartItem {
//   final String washer;
//   final String dryer;
//   final String fold;
//   final String total;
//
//   CartItem({
//     required this.washer,
//     required this.dryer,
//     required this.fold,
//     required this.total,
//   });
// }
//
// class UserCartPage extends StatelessWidget {
//   final List<CartItem> cartItems = [
//     CartItem(washer: '15 KG', dryer: '20 KG', fold: 'NONE', total: 'RM 15.00'),
//     CartItem(washer: '30 KG', dryer: '30 KG', fold: '15 KG', total: 'RM 25.00'),
//     // Add more items if needed
//   ];
//
//   const UserCartPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: const Color(0xFFE0F7FA),
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             children: [
//               // Header
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'List Cart',
//                     style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                       letterSpacing: 0.03,
//                     ),
//                   ),
//                   CircleAvatar(
//                     radius: 18,
//                     backgroundColor: const Color(0xFF2596BE),
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_back, size: 20, color: Colors.white),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//
//               // Cart List
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: cartItems.length,
//                 itemBuilder: (context, index) {
//                   final item = cartItems[index];
//                   return _buildCartItem(item);
//                 },
//               ),
//               const SizedBox(height: 80), // for bottom nav space
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCartItem(CartItem item) {
//     return Container(
//       margin: const EdgeInsets.only(top: 10),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         image: const DecorationImage(
//           image: AssetImage('assets/background2.png'), // <-- Your background2
//           fit: BoxFit.cover,
//         ),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             right: 10,
//             top: 20,
//             child: Image.asset(
//               'assets/imgcheckout.png',
//               width: 80,
//               height: 80,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Total : ${item.total}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Row(
//                 children: [
//                   const Text('Washer : ', style: TextStyle(fontSize: 12)),
//                   Text(item.washer, style: const TextStyle(fontSize: 12)),
//                 ],
//               ),
//               Row(
//                 children: [
//                   const Text('Dryer : ', style: TextStyle(fontSize: 12)),
//                   Text(item.dryer, style: const TextStyle(fontSize: 12)),
//                 ],
//               ),
//               Row(
//                 children: [
//                   const Text('Fold : ', style: TextStyle(fontSize: 12)),
//                   Text(item.fold, style: const TextStyle(fontSize: 12)),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
