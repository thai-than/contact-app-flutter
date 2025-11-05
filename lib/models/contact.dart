import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 2)
class Contact extends HiveObject {
  // Need to be update after create contact exeption email
  @HiveField(0)
  String firstName;
  @HiveField(1)
  String lastName;
  @HiveField(2)
  String phoneNumber;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? imageUrl;
  @HiveField(5)
  String? address;
  @HiveField(6)
  String? company;
  @HiveField(7)
  String? website;

  Contact({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.email,
    this.imageUrl,
    this.address,
    this.company,
    this.website,
  });

  String get fullName => '$firstName $lastName';

  @override
  String toString() {
    return 'Contact{firstName: $firstName, lastName: $lastName, email: $email, imageUrl: $imageUrl, phoneNumber: $phoneNumber, address: $address, company: $company, website: $website}';
  }

  // toStringJSON
  String toStringJSON() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'imageUrl': imageUrl,
      'address': address,
      'company': company,
      'website': website,
    }.toString();
  }
}
