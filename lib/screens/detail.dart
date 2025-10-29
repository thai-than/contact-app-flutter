import 'package:flutter/material.dart';
import 'package:sample_project/models/contact.dart';
import 'package:sample_project/widgets/contact_detail.dart';

class DetailScreen extends StatelessWidget {

  final Contact contact;

  const DetailScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          contact.fullName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: ContactDetailScreen(contact: contact),
    );
  }
}
