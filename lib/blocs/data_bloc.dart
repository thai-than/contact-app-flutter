import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/services/contact_service.dart';
import 'data_event.dart';
import 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitial()) {
    on<LoadData>(_onLoadData);
    on<RefreshData>(_onRefreshData);
    on<AddContact>(_onAddContact);
    on<DeleteContact>(_onDeleteContact);
    on<UpdateContact>(_onUpdateContact);
    on<SearchContact>(_onSearchContact);
  }

  Future<void> _onLoadData(LoadData event, Emitter<DataState> emit) async {
    emit(DataLoading());
    try {
      // Simulate data fetching
      await Future.delayed(const Duration(seconds: 1));
      final data = ContactService.getContacts();
      emit(DataLoaded(data));
    } catch (e) {
      emit(DataError(e.toString()));
    }
  }

  Future<void> _onRefreshData(
    RefreshData event,
    Emitter<DataState> emit,
  ) async {
    emit(DataLoading());
    try {
      // Simulate refresh
      await Future.delayed(const Duration(seconds: 1));
      final data = ContactService.getContacts();
      emit(DataLoaded(data));
    } catch (e) {
      emit(DataError(e.toString()));
    }
  }

  Future<void> _onAddContact(AddContact event, Emitter<DataState> emit) async {
    emit(DataLoading());
    try {
      await ContactService.addContact(event.contact);
      emit(DataLoaded(ContactService.getContacts()));
    } catch (e) {
      emit(DataError(e.toString()));
    }
  }

  Future<void> _onDeleteContact(
    DeleteContact event,
    Emitter<DataState> emit,
  ) async {
    emit(DataLoading());
    try {
      await ContactService.deleteContact(event.index);
      emit(DataLoaded(ContactService.getContacts()));
    } catch (e) {
      emit(DataError(e.toString()));
    }
  }

  Future<void> _onUpdateContact(
    UpdateContact event,
    Emitter<DataState> emit,
  ) async {
    emit(DataLoading());
    try {
      await ContactService.updateContact(
        contact: event.contact,
        index: event.index,
      );
      emit(DataLoaded(ContactService.getContacts()));
    } catch (e) {
      emit(DataError(e.toString()));
    }
  }

  Future<void> _onSearchContact(
    SearchContact event,
    Emitter<DataState> emit,
  ) async {
    emit(DataLoading());
    try {
      final data = ContactService.searchContacts(event.query);
      emit(DataLoaded(data));
    } catch (e) {
      emit(DataError(e.toString()));
    }
  }
}
