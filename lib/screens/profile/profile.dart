import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/blocs/user/user_cubit.dart';
import 'package:sample_project/blocs/user/user_state.dart';
import 'package:sample_project/utils/constant.dart';
import 'package:sample_project/widgets/contact_detail.dart';

class ProfileScreen extends StatelessWidget {
  final String? email;

  const ProfileScreen({super.key, this.email});

  // _onEditProfilePressed
  void _onEditProfilePressed(BuildContext context) {
    context.read<UserCubit>().goToEditProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text('My Info'),
          backgroundColor: kBgColor,
          elevation: 0,
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _onEditProfilePressed(context),
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                return ContactDetailScreen(contact: state.user.contact);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
