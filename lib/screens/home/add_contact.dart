import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/blocs/contact_list/contact_list_cubit.dart';
import 'package:sample_project/blocs/contact_list/contact_list_event.dart';
import 'package:sample_project/blocs/contact_list/contact_list_state.dart';
import 'package:sample_project/models/contact.dart';
import 'package:sample_project/widgets/contact_form.dart';

class AddContactScreen extends StatelessWidget {
  const AddContactScreen({super.key});

  Future<void> _onSubmit(BuildContext context, Contact newContact) async {
    context.read<ContactListCubit>().add(AddContact(newContact));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactListCubit(),
      child: BlocBuilder<ContactListCubit, ContactListState>(
        builder: (context, state) {
          return Column(
            children: [
              AppBar(
                title: const Text(
                  'Add New Contact',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: false,
              ),
              Expanded(
                child: Center(
                  child: ContactForm(
                    onSubmit: (contact) async {
                      await _onSubmit(context, contact);
                    },
                    isEditing: false,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
