import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/blocs/user/user_cubit.dart';
import 'package:sample_project/blocs/user/user_state.dart';
import 'package:sample_project/models/contact.dart';
import 'package:sample_project/models/user.dart';
import 'package:sample_project/utils/constant.dart';
import 'package:sample_project/widgets/contact_form.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  Future<void> _onSubmit(
    BuildContext context,
    Contact newContact,
    User user,
  ) async {
    final updateUser = User(
      contact: newContact,
      passcode: user.passcode,
      setting: user.setting,
    );
    await context.read<UserCubit>().updateUser(updateUser);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Column(
          children: [
            AppBar(
              title: const Text('Edit Profile'),
              backgroundColor: kBgColor,
              elevation: 0,
              centerTitle: false,
            ),
            Expanded(
              child: Center(
                child: BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is UserLoaded) {
                      return ContactForm(
                        contact: state.user.contact,
                        onSubmit: (newContact) async {
                          await _onSubmit(context, newContact, state.user);
                        },
                        isEditing: true,
                      );
                    } else if (state is UserError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
