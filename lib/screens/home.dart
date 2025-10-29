import 'package:flutter/material.dart';
import 'package:sample_project/widgets/contact_card.dart';
import 'package:sample_project/models/contact.dart';
import 'package:sample_project/services/contact_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Contact> contacts = ContactService.getContacts();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ContactCard(contact: contacts[index]);
        },
      ),
    );
  }
}
