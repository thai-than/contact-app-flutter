import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/blocs/data_bloc.dart';
import 'package:sample_project/models/contact.dart';
import 'package:sample_project/widgets/contact_form.dart';

class ModifyContactScreen extends StatelessWidget {
  final Contact contact;
  const ModifyContactScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataBloc(),
      child: Column(
        children: [
          AppBar(
            title: const Text(
              'Modify Contact',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
          ),
          Expanded(
            child: Center(child: ContactForm(contact: contact)),
          ),
        ],
      ),
    );
  }
}
