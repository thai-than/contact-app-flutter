import 'package:sample_project/models/contact.dart';

abstract class DataEvent {}

class LoadData extends DataEvent {}

class RefreshData extends DataEvent {}

class AddContact extends DataEvent {
  final Contact contact;
  AddContact(this.contact);
}

class DeleteContact extends DataEvent {
  final Contact contact;
  DeleteContact(this.contact);
}

class UpdateContact extends DataEvent {
  final Contact contact;
  UpdateContact(this.contact);
}

class SearchContact extends DataEvent {
  final String query;
  SearchContact(this.query);
}
