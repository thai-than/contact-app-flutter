
import 'package:sample_project/models/user.dart';

abstract class UserEvent {}

class LoadUser extends UserEvent {}

class CreateUser extends UserEvent {
  final User user;
  CreateUser(this.user);
}

class UpdateUser extends UserEvent {
  final User user;
  UpdateUser(this.user);
}

class DeleteUser extends UserEvent {}

class UserLogin extends UserEvent {}
