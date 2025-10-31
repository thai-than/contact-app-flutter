import 'package:hive_flutter/adapters.dart';
import 'package:sample_project/models/contact.dart';

class ContactService {
  static List<Contact> getContacts() {
    final box = Hive.box<Contact>('contacts');
    final contacts = box.values.toList();
    return contacts;
  }

  //getContactByEmail
  static Contact? getContactByEmail(String email) {
    try {
      final contacts = getContacts();
      return contacts.firstWhere((contact) => contact.email == email);
    } catch (e) {
      return null;
    }
  }

  // getMyContact
  static Contact getMyContact() {
    return Contact(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      imageUrl: 'assets/images/avatar.png',
      phoneNumber: '123-456-7890',
      address: '123 Main St, Anytown, USA',
      company: 'Sample Company',
      linkedIn: 'https://www.linkedin.com/in/johndoe',
      facebook: 'https://www.facebook.com/johndoe',
    );
  }

  static Future<int> addContact(Contact contact) async {
    final box = Hive.box<Contact>('contacts');
    final key = await box.add(contact);
    contact.key = key;
    return key;
  }

  static Future<void> deleteContact(int index) async {
    final box = Hive.box<Contact>('contacts');
    await box.deleteAt(index);
  }

  static Future<void> updateContact({required Contact contact, required int index}) async {
    final box = Hive.box<Contact>('contacts');
    await box.putAt(index, contact);
  }

  // search
  static List<Contact> searchContacts(String query) {
    final contacts = getContacts();
    return contacts
        .where(
          (contact) =>
              contact.fullName.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
