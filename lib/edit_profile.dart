import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final ref = FirebaseDatabase.instance.ref().child('Users/$uid');
      final snapshot = await ref.get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        setState(() {
          _nameController.text = data['name'] ?? '';
          _emailController.text = data['email'] ?? '';
          _genderController.text = data['gender'] ?? '';
          _phoneController.text = data['phone']?.toString() ?? '';
          isLoading = false;
        });
      }
    }
  }

  Future<void> saveChanges() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final ref = FirebaseDatabase.instance.ref().child('Users/$uid');
        await ref.update({
          'name': _nameController.text.trim(),
          'gender': _genderController.text.trim(),
          'phone': _phoneController.text.trim(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );

        Navigator.pop(context); // Go back to profile page
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: const Color(0xFF2596BE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField("Name", _nameController),
              _buildTextField("Email", _emailController, readOnly: true),
              _buildTextField("Gender", _genderController),
              _buildTextField("Phone", _phoneController),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2596BE),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: saveChanges,
                child: const Text(
                  "Save Changes",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller, {
        bool readOnly = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (!readOnly && (value == null || value.isEmpty)) {
            return "$label can't be empty";
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _genderController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
