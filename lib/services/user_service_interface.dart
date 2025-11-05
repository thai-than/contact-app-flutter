import 'package:sample_project/models/user.dart';

abstract class UserServiceInterface {
  User? getUser();
  Future<User> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser();
}
