import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/blocs/contact_detail/contact_detail_cubit.dart';
import 'package:sample_project/blocs/contact_detail/contact_detail_state.dart';
import 'package:sample_project/models/contact.dart';
import 'package:sample_project/widgets/contact_form.dart';

class ModifyContactScreen extends StatelessWidget {
  const ModifyContactScreen({super.key});

  Future<void> _onSubmit(BuildContext context, Contact newContact) async {
    context.read<ContactDetailCubit>().updateContact(newContact);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactDetailCubit, ContactDetailState>(
      builder: (context, state) {
        if (state is ContactDetailError) {
          return Center(child: Text(state.message));
        }
        if (state is ContactDetailLoading ||
            state is ContactDetailInitial ||
            state is ContactDetailDeleted) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
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
              child: Center(
                child: ContactForm(
                  contact: state.contact,
                  onSubmit: (contact) async {
                    await _onSubmit(context, contact);
                  },
                  isEditing: true,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
