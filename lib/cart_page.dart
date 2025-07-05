import 'package:flutter/material.dart';
import 'package:washywashy_laundry/userhistory_page.dart';
import 'package:washywashy_laundry/userprofile.dart';
import 'package:washywashy_laundry/widgets/cart_item.dart';
import 'package:washywashy_laundry/home_page.dart';

import 'package:firebase_database/firebase_database.dart';

class UserCartPage extends StatefulWidget {
  const UserCartPage({super.key});

  @override
  State<UserCartPage> createState() => _UserCartPageState();
}


class _UserCartPageState extends State<UserCartPage> {

  int _selectedIndex = 2;
  final List<Map<String, String>> cartItems = [];
  final Set<int> selectedIndices = {}; // ✅ For tracking selected items
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  void fetchCartData() async {
    final dbRef = FirebaseDatabase.instance.ref().child('Cart');
    final snapshot = await dbRef.get();

    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      final List<Map<String, String>> loadedItems = [];

      data.forEach((key, value) {
        final item = Map<String, String>.from(value);
        loadedItems.add(item);
      });

      setState(() {
        cartItems.clear();
        cartItems.addAll(loadedItems);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }


  void _onBottomNavTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const UserProfilePage()));
        break;
      case 2:
      // Already on Cart
        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const UserHistoryPage()));
        break;
    }
  }

  void _toggleSelection(int index) {
    setState(() {
      if (selectedIndices.contains(index)) {
        selectedIndices.remove(index);
      } else {
        selectedIndices.add(index);
      }
    });
  }

  void _deleteSelectedItems() async {
    final dbRef = FirebaseDatabase.instance.ref().child('Cart');
    final snapshot = await dbRef.get();

    if (!snapshot.exists) return;

    final data = snapshot.value as Map<dynamic, dynamic>;

    int currentIndex = 0;
    for (var entry in data.entries) {
      if (selectedIndices.contains(currentIndex)) {
        await dbRef.child(entry.key).remove(); // Delete from Firebase
      }
      currentIndex++;
    }

    setState(() {
      // Remove from end to avoid index shifting issues
      final indices = selectedIndices.toList()..sort((a, b) => b.compareTo(a));
      for (var index in indices) {
        cartItems.removeAt(index);
      }
      selectedIndices.clear();
    });
  }


  @override
  Widget build(BuildContext context) {

    // final List<Map<String, String>> cartItems = [
    //   {
    //     'total': selectedDryerPrice ?? 'RM 0.00',
    //     'washer': 'NONE',
    //     'dryer': selectedDryerKg ?? 'NONE',
    //     'fold': 'NONE',
    //   },
    // ];

    return Scaffold(
      backgroundColor: Colors.white,

      floatingActionButton: selectedIndices.isNotEmpty
          ? FloatingActionButton.extended(
        onPressed: _deleteSelectedItems,
        icon: const Icon(Icons.delete),
        label: const Text('Delete Selected'),
        backgroundColor: Colors.red,
      )
          : null,

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),


      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'List Cart',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.03,
                      color: Colors.black,
                    ),
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFF2596BE),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, size: 20, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Cart List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  final isSelected = selectedIndices.contains(index);

                  return GestureDetector(
                      onTap: () => _toggleSelection(index),
                      child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                      border: Border.all(
                      color: isSelected
                      ? Colors.blue
                          : Colors.transparent,
                      width: 2),
                  borderRadius: BorderRadius.circular(8),
                  ),
                  child: CartItem(
                    total: item['total']!,
                    washer: item['washer']!,
                    dryer: item['dryer']!,
                    fold: item['fold']!,
                  )),
                  );
                },
              ),

              const SizedBox(height: 80), // Space for bottom nav
            ],
          ),
        ),
      ),
    );
  }
}
