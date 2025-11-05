import 'package:hive/hive.dart';
import 'package:sample_project/models/contact.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  // Need to be update after create contact exeption email
  @HiveField(0)
  Contact contact;
  @HiveField(1)
  String? passcode;
  @HiveField(2)
  Setting? setting;

  User({required this.contact, this.passcode, this.setting});

  String get fullName => '${contact.firstName} ${contact.lastName}';

  @override
  String toString() {
    return 'User{contact: ${contact.toString()}, passcode: $passcode, setting: ${setting.toString()}}';
  }
}

@HiveType(typeId: 1)
class Setting extends HiveObject {
  @HiveField(0)
  bool isDarkMode;
  @HiveField(1)
  String language;
  @HiveField(2)
  String fontSize;
  @HiveField(3)
  bool enableBiometric;

  Setting({
    required this.isDarkMode,
    required this.language,
    required this.fontSize,
    required this.enableBiometric,
  });

  @override
  String toString() {
    return 'Setting{isDarkMode: $isDarkMode, language: $language, fontSize: $fontSize, enableBiometric: $enableBiometric}';
  }
}
