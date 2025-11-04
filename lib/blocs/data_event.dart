import 'package:sample_project/models/contact.dart';

abstract class DataEvent {}

class LoadData extends DataEvent {}

class RefreshData extends DataEvent {}

class AddContact extends DataEvent {
  final Contact contact;
  AddContact(this.contact);
}

class DeleteContact extends DataEvent {
  final int index;
  DeleteContact(this.index);
}

class UpdateContact extends DataEvent {
  final Contact contact;
  final int index;
  UpdateContact(this.contact, this.index);
}

class SearchContact extends DataEvent {
  final String query;
  SearchContact(this.query);
}

class GetMyContact extends DataEvent {}

class GetContactById extends DataEvent {
  final int id;
  GetContactById(this.id);
}

class GetContactByEmail extends DataEvent {
  final String email;
  GetContactByEmail(this.email);
}
