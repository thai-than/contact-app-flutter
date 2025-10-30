import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/widgets/contact_card.dart';
import 'package:sample_project/blocs/data_bloc.dart';
import 'package:sample_project/blocs/data_event.dart';
import 'package:sample_project/blocs/data_state.dart';
import 'package:sample_project/widgets/search_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DataBloc>().add(LoadData());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: const Text(
            'Contact',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          // add search input to app bar
          actions: [
            SearchInput(
              controller: TextEditingController(),
              onChanged: (value) {
                context.read<DataBloc>().add(SearchContact(value));
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => context.read<DataBloc>().add(RefreshData()),
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<DataBloc, DataState>(
            builder: (context, state) {
              if (state is DataInitial) {
                return const Center(child: Text('Press load to fetch contacts'));
              } else if (state is DataLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DataLoaded) {
                return ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return ContactCard(contact: state.data[index]);
                  },
                );
              } else if (state is DataError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
