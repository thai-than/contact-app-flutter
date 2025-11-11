import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/utils/constant.dart';
import 'package:sample_project/widgets/contact_card.dart';
import 'package:sample_project/blocs/contact_list/contact_list_cubit.dart';
import 'package:sample_project/blocs/contact_list/contact_list_event.dart';
import 'package:sample_project/blocs/contact_list/contact_list_state.dart';
import 'package:sample_project/widgets/search_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<ContactListCubit>().add(LoadContacts());
  }

  void _onSearch(String value) {
    context.read<ContactListCubit>().add(SearchContact(value));
  }

  void _onRefresh() {
    context.read<ContactListCubit>().add(RefreshContacts());
  }

  void _onAddContactButtonTapped() {
    context.read<ContactListCubit>().onAddContactButtonTapped();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          // add search input to app bar
          actions: [
            SearchInput(controller: _searchController, onChanged: _onSearch),
            IconButton(icon: const Icon(Icons.refresh), onPressed: _onRefresh),
          ],
        ),
        Expanded(
          child: BlocBuilder<ContactListCubit, ContactListState>(
            builder: (context, state) {
              if (state is ContactListInitial) {
                return const Center(
                  child: Text('Press load to fetch contacts'),
                );
              } else if (state is ContactListLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ContactListLoaded && state.data.isNotEmpty) {
                return ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return ContactCard(
                      contact: state.data[index],
                      index: index,
                    );
                  },
                );
              } else if (state is ContactListLoaded && state.data.isEmpty) {
                return const Center(child: Text('No contacts found!'));
              } else if (state is ContactListError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            onPressed: _onAddContactButtonTapped,
            tooltip: 'Add contact',
            backgroundColor: kPrimaryColor,
            elevation: 2,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: kBgColor),
          ),
        ),
      ],
    );
  }
}
