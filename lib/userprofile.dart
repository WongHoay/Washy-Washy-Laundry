import 'package:flutter/material.dart';
import 'package:washywashy_laundry/sign_in.dart';
import 'package:washywashy_laundry/edit_profile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String name = '';
  String email = '';
  String gender = '';
  String phone = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      print("UID: $uid");

      if (uid != null) {
        final ref = FirebaseDatabase.instance.ref().child('Users/$uid');
        final snapshot = await ref.get();

        if (snapshot.exists) {
          final data = Map<String, dynamic>.from(snapshot.value as Map);
          print("User data: $data");

          setState(() {
            name = data['name'] ?? '';
            email = data['email'] ?? '';
            gender = data['gender'] ?? '';
            phone = data['phone']?.toString() ?? '';
            isLoading = false;
          });
        } else {
          print("No user data found in Realtime DB.");
        }
      } else {
        print("User is not logged in");
      }
    } catch (e) {
      print("Error fetching user data from Realtime DB: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFE0F7FA),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 1, // Profile is index 1
        onTap: (index) {
          if (index == 1) return; // Already on profile

          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/cart');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/history');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Handle refresh logic
          await fetchUserData();
        },
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFF2596BE),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                const Text(
                  "Profile Details",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2D2D),
                    letterSpacing: 0.03,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundImage: AssetImage('assets/imgprofile.png'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Welcome, $name',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          textBaseline: TextBaseline.alphabetic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow('assets/imgname.png', name),
                      _buildDivider(),
                      _buildInfoRow('assets/imgemail.png', email),
                      _buildDivider(),
                      _buildInfoRow('assets/imggender.png', gender),
                      _buildDivider(),
                      _buildInfoRow('assets/imgphone.png', phone),
                      _buildDivider(),
                      TextButton(
                        onPressed: () {
                          // Navigate to edit profile
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EditProfilePage()),
                          );
                        },
                        child: const Text(
                          'Edit Your Profile',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle logout
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignInPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9292),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String iconPath, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Image.asset(iconPath, width: 30, height: 30, color: const Color(0xFF0A5078)),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(color: Colors.black, height: 1),
    );
  }
}
