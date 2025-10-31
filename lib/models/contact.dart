import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 0)
class Contact extends HiveObject {
  // Need to be update after create contact exeption email
  @HiveField(0)
  String firstName;
  @HiveField(1)
  String lastName;
  @HiveField(2)
  final String email;
  @HiveField(3)
  String imageUrl;
  @HiveField(4)
  String? phoneNumber;
  @HiveField(5)
  String? address;
  @HiveField(6)
  String? company;
  @HiveField(7)
  String? facebook;
  @HiveField(8)
  String? linkedIn;
  @HiveField(9)
  int? key;

  Contact({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
    this.phoneNumber,
    this.address,
    this.company,
    this.facebook,
    this.linkedIn,
    this.key,
  });

  String get fullName => '$firstName $lastName';

  void updateContact({
    String? firstName,
    String? lastName,
    String? imageUrl,
    String? phoneNumber,
    String? address,
    String? company,
    String? facebook,
    String? linkedIn,
  }) {
    if (firstName != null) {
      this.firstName = firstName;
    }
    if (lastName != null) {
      this.lastName = lastName;
    }
    if (imageUrl != null) {
      this.imageUrl = imageUrl;
    }
    if (phoneNumber != null) {
      this.phoneNumber = phoneNumber;
    }
    if (address != null) {
      this.address = address;
    }
    if (company != null) {
      this.company = company;
    }
    if (facebook != null) {
      this.facebook = facebook;
    }
    if (linkedIn != null) {
      this.linkedIn = linkedIn;
    }
  }
}
