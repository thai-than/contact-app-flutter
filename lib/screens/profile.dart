import 'package:flutter/material.dart';
import 'package:sample_project/widgets/contact_detail.dart';
import 'package:sample_project/services/contact_service.dart';

class ProfileScreen extends StatelessWidget {

  final String? email;

  const ProfileScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Info',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: ContactDetailScreen(contact: ContactService.getMyContact()),
    );
  }
}
