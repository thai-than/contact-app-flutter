import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/blocs/user/user_state.dart';
import 'package:sample_project/models/user.dart';
import 'package:sample_project/router/router.dart';
import 'package:sample_project/services/user_service.dart';

class UserCubit extends Cubit<UserState> {
  final UserService _userService;
  final GoRouter _router;

  UserCubit()
    : _userService = UserService(),
      _router = router,
      super(UserInitial());

  Future<void> loadUser() async {
    try {
      final user = _userService.getUser();
      if (user == null) {
        _router.goNamed(RouteNames.register);
        emit(UserLoadedEmpty());
      } else {
        emit(UserLoaded(user));
        _router.goNamed(RouteNames.login);
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> createUser(User user) async {
    try {
      await _userService.createUser(user);
      emit(UserLoaded(user));
      _router.goNamed(RouteNames.home);
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> updateUser(User user) async {
    try {
      await _userService.updateUser(user);
      emit(UserLoaded(user));
      _router.goNamed(RouteNames.profile);
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> deleteUser() async {
    try {
      await _userService.deleteUser();
      emit(UserLoadedEmpty());
      _router.goNamed(RouteNames.register);
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> login(String passcode) async {
    try {
      final user = _userService.getUser();
      if (user != null && user.passcode == passcode) {
        emit(UserLoaded(user));
        _router.goNamed(RouteNames.home);
      } else {
        emit(UserError('Invalid passcode'));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> goToEditProfile() async {
    try {
      final user = _userService.getUser();
      if (user != null) {
        emit(UserLoaded(user));
        _router.goNamed(RouteNames.editProfile);
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> toggleDarkMode() async {
    try {
      final user = _userService.getUser();
      if (user != null) {
        final currentSetting =
            user.setting ??
            Setting(
              isDarkMode: false,
              language: 'en',
              fontSize: 'Medium',
              enableBiometric: false,
            );
        final updatedSetting = Setting(
          isDarkMode: !currentSetting.isDarkMode,
          language: currentSetting.language,
          fontSize: currentSetting.fontSize,
          enableBiometric: currentSetting.enableBiometric,
        );
        final updatedUser = User(
          contact: user.contact,
          passcode: user.passcode,
          setting: updatedSetting,
        );
        await _userService.updateUser(updatedUser);
        emit(UserLoaded(updatedUser));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  bool getUserAppearanceMode() {
    final user = _userService.getUser();
    if (user != null) {
      return user.setting?.isDarkMode ?? false;
    }
    return false;
  }
}
