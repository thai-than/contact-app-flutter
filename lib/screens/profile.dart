import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/blocs/data_bloc.dart';
import 'package:sample_project/blocs/data_state.dart';
import 'package:sample_project/widgets/contact_detail.dart';

class ProfileScreen extends StatelessWidget {
  final String? email;

  const ProfileScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text(
            'My Info',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          actions: [IconButton(icon: const Icon(Icons.edit), onPressed: () {})],
        ),
        Expanded(
          child: BlocBuilder<DataBloc, DataState>(
            builder: (context, state) {
              if (state is DataLoaded) {
                return ContactDetailScreen(contact: state.myContact!);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
