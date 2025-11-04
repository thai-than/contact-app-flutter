import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/services/contact_service.dart';
import 'data_event.dart';
import 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final ContactService _contactService;

  DataBloc({ContactService? contactService})
    : _contactService = contactService ?? ContactService(),
      super(DataInitial()) {
    on<LoadData>(_onLoadData);
    on<RefreshData>(_onRefreshData);
    on<AddContact>(_onAddContact);
    on<DeleteContact>(_onDeleteContact);
    on<UpdateContact>(_onUpdateContact);
    on<SearchContact>(_onSearchContact);
    on<GetContactByEmail>(_onGetContactByEmail);
  }

  Future<void> _onLoadData(LoadData event, Emitter<DataState> emit) async {
    emit(DataLoading());
    try {
      await Future.delayed(
        const Duration(milliseconds: 300),
      ); // optional UX delay
      final data = _contactService.getContacts();
      final myContact = _contactService.getMyContact();
      emit(DataLoaded(data, myContact: myContact));
    } catch (e) {
      emit(DataError('Failed to load contacts: $e'));
    }
  }

  Future<void> _onRefreshData(
    RefreshData event,
    Emitter<DataState> emit,
  ) async {
    emit(DataLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final data = _contactService.getContacts();
      emit(DataLoaded(data));
    } catch (e) {
      emit(DataError('Failed to refresh contacts: $e'));
    }
  }

  Future<void> _onAddContact(AddContact event, Emitter<DataState> emit) async {
    emit(DataLoading());
    try {
      await _contactService.addContact(event.contact);
      final updatedContacts = _contactService.getContacts();
      emit(DataLoaded(updatedContacts));
    } catch (e) {
      emit(DataError('Failed to add contact: $e'));
    }
  }

  Future<void> _onDeleteContact(
    DeleteContact event,
    Emitter<DataState> emit,
  ) async {
    emit(DataLoading());
    try {
      await _contactService.deleteContact(event.index);
      final updatedContacts = _contactService.getContacts();
      emit(DataLoaded(updatedContacts));
    } catch (e) {
      emit(DataError('Failed to delete contact: $e'));
    }
  }

  Future<void> _onUpdateContact(
    UpdateContact event,
    Emitter<DataState> emit,
  ) async {
    emit(DataLoading());
    try {
      await _contactService.updateContact(
        index: event.index,
        contact: event.contact,
      );
      final updatedContacts = _contactService.getContacts();
      emit(DataLoaded(updatedContacts));
    } catch (e) {
      emit(DataError('Failed to update contact: $e'));
    }
  }

  Future<void> _onSearchContact(
    SearchContact event,
    Emitter<DataState> emit,
  ) async {
    emit(DataLoading());
    try {
      final results = _contactService.searchContacts(event.query);
      emit(DataLoaded(results));
    } catch (e) {
      emit(DataError('Failed to search contacts: $e'));
    }
  }

  Future<void> _onGetContactByEmail(
    GetContactByEmail event,
    Emitter<DataState> emit,
  ) async {
    emit(DataLoading());
    try {
      final contact = _contactService.getContactByEmail(event.email);
      emit(DataLoaded([contact!]));
    } catch (e) {
      emit(DataError('Failed to get contact by email: $e'));
    }
  }
}
