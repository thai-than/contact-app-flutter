import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/blocs/data_bloc.dart';
import 'package:sample_project/blocs/data_event.dart';
import 'package:sample_project/blocs/data_state.dart';
import 'package:sample_project/models/contact.dart';
import 'package:sample_project/router/router.dart';
import 'package:sample_project/widgets/contact_detail.dart';

class DetailScreen extends StatelessWidget {
  final Contact contact;
  final int index;

  const DetailScreen({super.key, required this.contact, required this.index});

  Future<void> _confirmDelete(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Contact'),
        content: Text('Are you sure you want to delete "${contact.fullName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.delete_outline),
            label: const Text('Delete'),
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade600),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      context.read<DataBloc>().add(DeleteContact(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DataBloc, DataState>(
      listenWhen: (previous, current) => current is DataLoaded,
      listener: (context, state) {
        if (state is DataLoaded && !state.data.contains(contact)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Contact deleted successfully'),
              backgroundColor: Colors.red.shade600,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
          context.goNamed(RouteNames.home);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            contact.fullName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          actions: [
            IconButton(
              tooltip: 'Edit contact',
              icon: const Icon(Icons.edit, color: Colors.black87),
              onPressed: () => context.goNamed(
                RouteNames.modify,
                pathParameters: {'index': index.toString()},
                extra: contact,
              ),
            ),
            IconButton(
              tooltip: 'Delete contact',
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: () => _confirmDelete(context),
            ),
          ],
        ),
        body: SafeArea(child: ContactDetailScreen(contact: contact)),
      ),
    );
  }
}
