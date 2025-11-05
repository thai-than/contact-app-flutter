import 'package:hive/hive.dart';
import 'package:sample_project/models/user.dart';
import 'package:sample_project/services/user_service_interface.dart';

class UserService extends UserServiceInterface {
  final Box<User> _box = Hive.box<User>('users');

  @override
    User? getUser() => _box.isEmpty ? null : _box.getAt(0);
  
  @override
  Future<User> createUser(User user) async {
    await _box.clear();
    await _box.add(user);
    return user;
  }

  @override
  Future<void> updateUser(User user) async {
    await _box.putAt(0, user);
  }

  @override
  Future<void> deleteUser() async {
    await _box.clear();
  }
}
