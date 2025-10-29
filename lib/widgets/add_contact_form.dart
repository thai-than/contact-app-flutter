import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_project/models/contact.dart';
import 'package:sample_project/screens/home.dart';
import 'package:sample_project/widgets/input.dart';

class AddContactForm extends StatefulWidget {
  const AddContactForm({super.key});

  @override
  State<AddContactForm> createState() => _AddContactFormState();
}

class _AddContactFormState extends State<AddContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _imageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _companyController = TextEditingController();
  final _linkedinController = TextEditingController();
  File? _imageFile;

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _imageController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _companyController.dispose();
    _linkedinController.dispose();
    _imageFile?.delete();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final firstname = _firstnameController.text.trim();
      final lastname = _lastnameController.text.trim();
      final email = _emailController.text.trim();

      final newContact = Contact(
        firstName: firstname,
        lastName: lastname,
        email: email,
        phoneNumber: _phoneController.text.trim(),
        address: _addressController.text.trim(),
        company: _companyController.text.trim(),
        linkedIn: _linkedinController.text.trim(),
        imageUrl: _imageFile?.path ?? 'assets/images/avatar.png',
      );

      final box = await Hive.openBox<Contact>('contacts');
      await box.add(newContact);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text('✅ Contact saved: $firstname $lastname')),
          backgroundColor: Colors.lightGreen.shade500,
          duration: const Duration(seconds: 2),
        ),
      );

      _formKey.currentState!.reset();
      setState(() {
        _imageFile = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFC5C5C5), width: 1),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: SingleChildScrollView(
            // ✅ enables scrolling if content overflows
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                          child: GestureDetector(
                            onTap: _pickImage, // 👈 tap to change avatar
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: _imageFile != null
                                  ? FileImage(_imageFile!) as ImageProvider
                                  : const AssetImage(
                                      'assets/images/avatar.png',
                                    ),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                    color: Color(0xFF5EBBC6),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              CustomInput(
                                controller: _firstnameController,
                                labelText: 'Firstname',
                                validator: (value) =>
                                    value == null || value.isEmpty
                                    ? 'Please enter a name'
                                    : null,
                              ),
                              CustomInput(
                                controller: _lastnameController,
                                labelText: 'Lastname',
                                validator: (value) =>
                                    value == null || value.isEmpty
                                    ? 'Please enter a name'
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    CustomInput(
                      controller: _emailController,
                      labelText: 'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    CustomInput(
                      controller: _phoneController,
                      labelText: 'Phone',
                    ),
                    CustomInput(
                      controller: _addressController,
                      labelText: 'Address',
                    ),
                    CustomInput(
                      controller: _companyController,
                      labelText: 'Company',
                    ),
                    CustomInput(
                      controller: _linkedinController,
                      labelText: 'LinkedIn',
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5EBBC6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 32,
                        ),
                      ),
                      child: const Text(
                        'Add New Contact',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
