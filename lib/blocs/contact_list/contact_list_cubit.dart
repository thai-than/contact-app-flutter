import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/router/router.dart';
import 'package:sample_project/services/contact_service.dart';
import 'contact_list_event.dart';
import 'contact_list_state.dart';

class ContactListCubit extends Bloc<ContactListEvent, ContactListState> {
  final ContactService _contactService;
  final GoRouter _router;

  ContactListCubit({ContactService? contactService})
    : _contactService = contactService ?? ContactService(),
      _router = router,
      super(ContactListInitial()) {
    on<LoadContacts>(_onLoadData);
    on<RefreshContacts>(_onRefreshData);
    on<AddContact>(_onAddContact);
    on<SearchContact>(_onSearchContact);
    on<GoToContactDetails>(_onGoToContactDetails);
    on<GoToEditContact>(_onGoToEditContact);
  }

  Future<void> _onLoadData(
    LoadContacts event,
    Emitter<ContactListState> emit,
  ) async {
    emit(ContactListLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final data = _contactService.getContacts();
      emit(ContactListLoaded(data));
    } catch (e) {
      emit(ContactListError('Failed to load contacts: $e'));
    }
  }

  Future<void> _onRefreshData(
    RefreshContacts event,
    Emitter<ContactListState> emit,
  ) async {
    emit(ContactListLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final data = _contactService.getContacts();
      emit(ContactListLoaded(data));
    } catch (e) {
      emit(ContactListError('Failed to refresh contacts: $e'));
    }
  }

  Future<void> _onAddContact(
    AddContact event,
    Emitter<ContactListState> emit,
  ) async {
    emit(ContactListLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      await _contactService.addContact(event.contact);
      final data = _contactService.getContacts();
      emit(ContactListLoaded(data));
      _router.goNamed(RouteNames.home);
    } catch (e) {
      emit(ContactListError('Failed to add contact: $e'));
    }
  }

  Future<void> _onSearchContact(
    SearchContact event,
    Emitter<ContactListState> emit,
  ) async {
    emit(ContactListLoading());
    try {
      final results = _contactService.searchContacts(event.query);
      emit(ContactListLoaded(results, query: event.query));
    } catch (e) {
      emit(ContactListError('Failed to search contacts: $e'));
    }
  }

  Future<void> _onGoToContactDetails(
    GoToContactDetails event,
    Emitter<ContactListState> emit,
  ) async {
    final contact = event.contact;
    final index = event.index;
    _router.pushNamed(
      RouteNames.contact,
      pathParameters: {'index': index.toString()},
      extra: contact,
    );
  }

  Future<void> _onGoToEditContact(
    GoToEditContact event,
    Emitter<ContactListState> emit,
  ) async {
    final contact = event.contact;
    final index = event.index;
    _router.pushNamed(
      RouteNames.editContact,
      pathParameters: {'index': index.toString()},
      extra: contact,
    );
  }

  void onAddContactButtonTapped() {
    _router.pushNamed(RouteNames.add);
  }
}
