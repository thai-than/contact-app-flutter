import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/models/contact.dart';
import 'package:sample_project/router/router.dart';
import 'package:sample_project/services/contact_service.dart';
import 'contact_detail_state.dart';

class ContactDetailCubit extends Cubit<ContactDetailState> {
  final ContactService _contactService;
  final GoRouter _router;
  final int index;

  ContactDetailCubit({ContactService? contactService, required this.index})
    : _contactService = contactService ?? ContactService(),
      _router = router,
      super(ContactDetailInitial()) {
    _onInitializeContactDetail();
  }

  Future<void> _onInitializeContactDetail() async {
    try {
      emit(ContactDetailLoading());
      final contact = _contactService.getContactByIndex(index);
      emit(ContactDetailLoaded(contact!, index));
    } catch (e) {
      emit(ContactDetailError('Failed to load contact: $e'));
    }
  }

  Future<void> deleteContact() async {
    emit(ContactDetailLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      await _contactService.deleteContact(index);
      emit(ContactDetailDeleted());
      _router.goNamed(RouteNames.home);
    } catch (e) {
      emit(ContactDetailError('Failed to delete contact: $e'));
    }
  }

  Future<void> updateContact(Contact contact) async {
    emit(ContactDetailLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      await _contactService.updateContact(index: index, contact: contact);
      emit(ContactDetailLoaded(contact, index));
      _router.goNamed(
        RouteNames.contact,
        pathParameters: {'index': index.toString()},
        extra: contact,
      );
    } catch (e) {
      emit(ContactDetailError('Failed to update contact: $e'));
    }
  }

  Future<void> goToEditContact() async {
    _router.pushNamed(
      RouteNames.editContact,
      pathParameters: {'index': index.toString()},
    );
  }
}
