import 'package:sample_project/models/contact.dart';

abstract class ContactListEvent {}

class LoadContacts extends ContactListEvent {}

class RefreshContacts extends ContactListEvent {}

class AddContact extends ContactListEvent {
  final Contact contact;
  AddContact(this.contact);
}

class SearchContact extends ContactListEvent {
  final String query;
  SearchContact(this.query);
}

class GetContactById extends ContactListEvent {
  final int id;
  GetContactById(this.id);
}

class GoToContactDetails extends ContactListEvent {
  final Contact contact;
  final int index;
  GoToContactDetails(this.contact, this.index);
}

class GoToEditContact extends ContactListEvent {
  final Contact contact;
  final int index;
  GoToEditContact(this.contact, this.index);
}
