import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/blocs/contact_detail/contact_detail_cubit.dart';
import 'package:sample_project/blocs/contact_detail/contact_detail_state.dart';
import 'package:sample_project/blocs/contact_list/contact_list_cubit.dart';
import 'package:sample_project/blocs/contact_list/contact_list_event.dart';
import 'package:sample_project/blocs/user/user_cubit.dart';
import 'package:sample_project/utils/constant.dart';
import 'package:sample_project/widgets/contact_detail.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  Future<void> _confirmDelete(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Contact'),
        content: Text('Are you sure you want to delete this contact?'),
        backgroundColor: context.read<UserCubit>().getUserAppearanceMode()
            ? kDarkColor
            : kBgColor,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.pop(dialogContext, true),
            icon: const Icon(Icons.delete_outline),
            label: const Text('Delete'),
            style: FilledButton.styleFrom(backgroundColor: kDangerColor),
          ),
        ],
      ),
    );

    if (shouldDelete == true && context.mounted) {
      context.read<ContactDetailCubit>().deleteContact();
    }
  }

  Future<void> _onGoToEditContact(BuildContext context) async {
    context.read<ContactDetailCubit>().goToEditContact();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactDetailCubit, ContactDetailState>(
      listenWhen: (previous, current) => current is ContactDetailDeleted,
      listener: (context, state) {
        if (state is ContactDetailDeleted) {
          context.read<ContactListCubit>().add(RefreshContacts());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Contact deleted successfully'),
              backgroundColor: kSuccessColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: BlocBuilder<ContactDetailCubit, ContactDetailState>(
        builder: (context, state) {
          if (state is ContactDetailLoading ||
              state is ContactDetailDeleted ||
              state is ContactDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state.contact!.fullName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: false,
              actions: [
                IconButton(
                  tooltip: 'Edit contact',
                  icon: const Icon(Icons.edit, color: Colors.black87),
                  onPressed: () => _onGoToEditContact(context),
                ),
                IconButton(
                  tooltip: 'Delete contact',
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                  ),
                  onPressed: () => _confirmDelete(context),
                ),
              ],
            ),
            body: SafeArea(child: ContactDetailScreen(contact: state.contact!)),
          );
        },
      ),
    );
  }
}
