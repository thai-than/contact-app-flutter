import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/blocs/user/user_cubit.dart';
import 'package:sample_project/blocs/user/user_state.dart';
import 'package:sample_project/utils/constant.dart';
import 'package:sample_project/widgets/button.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        // Handle state changes if needed
      },
      builder: (context, state) {
        final userCubit = context.read<UserCubit>();
        final isDarkMode =
            state is UserLoaded && state.user.setting?.isDarkMode == true;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Settings"),
            backgroundColor: kBgColor,
            elevation: 0,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Appearance Mode
                  _buildRow(
                    title: "Appearance Mode",
                    trailing: Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        userCubit.toggleDarkMode();
                      },
                    ),
                  ),
                  _buildRow(title: "Language", phase: "Coming soon"),
                  _buildRow(title: "Font Size", phase: "Coming soon"),
                  _buildRow(
                    title: "Enable Login by Fingerprint",
                    phase: "Coming soon",
                  ),
                  _buildRow(title: "App Version", phase: "v1.0.0"),
                  const SizedBox(height: 10),

                  _buildGestureDetector(
                    title: "Terms & Conditions",
                    onTap: () {},
                    color: const Color(0xFF5A5BFF),
                  ),
                  _buildGestureDetector(
                    title: "Privacy Policy",
                    onTap: () {},
                    color: const Color(0xFF5A5BFF),
                  ),

                  const SizedBox(height: 20),

                  CustomButton(
                    onPressed: () {},
                    text: "Change Passcode",
                    variant: 'info',
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    onPressed: () {},
                    text: "Delete Account",
                    variant: 'danger',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRow({required String title, Widget? trailing, String? phase}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
              trailing ??
                  (phase != null
                      ? Text(phase, style: const TextStyle(color: Colors.grey))
                      : const SizedBox.shrink()),
            ],
          ),
        ),
        const Divider(height: 24, color: Colors.black12),
      ],
    );
  }

  Widget _buildGestureDetector({
    required String title,
    required Function() onTap,
    Color? color,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: onTap,
            child: Text(
              title,
              style: TextStyle(color: color, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
