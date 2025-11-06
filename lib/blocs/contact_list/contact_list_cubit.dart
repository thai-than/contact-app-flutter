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
    on<DeleteContact>(_onDeleteContact);
    on<UpdateContact>(_onUpdateContact);
    on<SearchContact>(_onSearchContact);
    on<GetContactByEmail>(_onGetContactByEmail);
    on<GoToContactDetails>(_onGoToContactDetails);
    on<GoToEditContact>(_onGoToEditContact);
  }

  Future<void> _onLoadData(
    LoadContacts event,
    Emitter<ContactListState> emit,
  ) async {
    emit(ContactListLoading());
    try {
      await Future.delayed(
        const Duration(milliseconds: 300),
      ); // optional UX delay
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
      await _contactService.addContact(event.contact);
      final data = _contactService.getContacts();
      emit(ContactListLoaded(data));
      _router.goNamed(RouteNames.home);
    } catch (e) {
      emit(ContactListError('Failed to add contact: $e'));
    }
  }

  Future<void> _onDeleteContact(
    DeleteContact event,
    Emitter<ContactListState> emit,
  ) async {
    emit(ContactListLoading());
    try {
      await _contactService.deleteContact(event.index);
      final data = _contactService.getContacts();
      emit(ContactListLoaded(data));
      _router.goNamed(RouteNames.home);
    } catch (e) {
      emit(ContactListError('Failed to delete contact: $e'));
    }
  }

  Future<void> _onUpdateContact(
    UpdateContact event,
    Emitter<ContactListState> emit,
  ) async {
    emit(ContactListLoading());
    try {
      await _contactService.updateContact(
        index: event.index,
        contact: event.contact,
      );
      final updatedContacts = _contactService.getContacts();
      emit(ContactListLoaded(updatedContacts));
      _router.goNamed(
        RouteNames.contact,
        pathParameters: {'index': event.index.toString()},
        extra: event.contact,
      );
    } catch (e) {
      emit(ContactListError('Failed to update contact: $e'));
    }
  }

  Future<void> _onSearchContact(
    SearchContact event,
    Emitter<ContactListState> emit,
  ) async {
    emit(ContactListLoading());
    try {
      final results = _contactService.searchContacts(event.query);
      emit(ContactListLoaded(results));
    } catch (e) {
      emit(ContactListError('Failed to search contacts: $e'));
    }
  }

  Future<void> _onGetContactByEmail(
    GetContactByEmail event,
    Emitter<ContactListState> emit,
  ) async {
    emit(ContactListLoading());
    try {
      final contact = _contactService.getContactByEmail(event.email);
      emit(ContactListLoaded([contact!]));
    } catch (e) {
      emit(ContactListError('Failed to get contact by email: $e'));
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
