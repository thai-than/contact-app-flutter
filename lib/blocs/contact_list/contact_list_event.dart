import 'package:sample_project/models/contact.dart';

abstract class ContactListEvent {}

class LoadContacts extends ContactListEvent {}

class RefreshContacts extends ContactListEvent {}

class AddContact extends ContactListEvent {
  final Contact contact;
  AddContact(this.contact);
}

class DeleteContact extends ContactListEvent {
  final int index;
  DeleteContact(this.index);
}

class UpdateContact extends ContactListEvent {
  final Contact contact;
  final int index;
  UpdateContact(this.contact, this.index);
}

class SearchContact extends ContactListEvent {
  final String query;
  SearchContact(this.query);
}

class GetContactById extends ContactListEvent {
  final int id;
  GetContactById(this.id);
}

class GetContactByEmail extends ContactListEvent {
  final String email;
  GetContactByEmail(this.email);
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
