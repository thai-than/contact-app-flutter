import 'package:hive_flutter/adapters.dart';
import 'package:sample_project/models/contact.dart';
import 'package:sample_project/services/contact_service_interface.dart';

class ContactService implements ContactServiceInterface {
  final Box<Contact> _box = Hive.box<Contact>('contacts');

  @override
  List<Contact> getContacts() => _box.values.toList();

  @override
  Contact? getContactByEmail(String email) {
    try {
      return _box.values.firstWhere((c) => c.email == email);
    } catch (_) {
      return null;
    }
  }

  @override
  Contact getMyContact() => Contact(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@example.com',
    imageUrl: 'assets/images/avatar.png',
    phoneNumber: '123-456-7890',
    address: '123 Main St, Anytown, USA',
    company: 'Sample Company',
    linkedIn: 'https://linkedin.com/in/johndoe',
    facebook: 'https://facebook.com/johndoe',
  );

  @override
  Future<Contact> addContact(Contact contact) async {
    final key = await _box.add(contact);
    return _box.get(key)!;
  }

  @override
  Future<void> deleteContact(int index) async {
    await _box.deleteAt(index);
  }

  @override
  Future<void> updateContact({
    required int index,
    required Contact contact,
  }) async {
    await _box.putAt(index, contact);
  }

  @override
  List<Contact> searchContacts(String query) {
    final q = query.trim().toLowerCase();
    return _box.values
        .where(
          (c) =>
              c.fullName.toLowerCase().contains(q) ||
              c.email.toLowerCase().contains(q),
        )
        .toList();
  }
}
