import 'package:sample_project/models/contact.dart';

abstract class ContactServiceInterface {
  List<Contact> getContacts();
  Contact? getContactByEmail(String email);
  Contact getMyContact();
  Future<Contact> addContact(Contact contact);
  Future<void> deleteContact(int index);
  Future<void> updateContact({required int index, required Contact contact});
  List<Contact> searchContacts(String query);
}
