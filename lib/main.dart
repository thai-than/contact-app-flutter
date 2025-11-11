import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_project/models/contact.dart';
import 'package:sample_project/models/user.dart';
import 'package:sample_project/router/router.dart';
import 'package:sample_project/blocs/contact_list/contact_list_cubit.dart';
import 'package:sample_project/blocs/user/user_cubit.dart';
import 'package:sample_project/blocs/user/user_state.dart';
import 'package:sample_project/utils/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(SettingAdapter());
  // await Hive.deleteBoxFromDisk('settings');
  // await Hive.deleteBoxFromDisk('contacts');
  // await Hive.deleteBoxFromDisk('users');
  await Hive.openBox<Contact>('contacts');
  await Hive.openBox<User>('users');
  await Hive.openBox<Setting>('settings');

  runApp(const ContactManagerApp());
}

class ContactManagerApp extends StatefulWidget {
  const ContactManagerApp({super.key});

  @override
  State<ContactManagerApp> createState() => _ContactManagerAppState();
}

class _ContactManagerAppState extends State<ContactManagerApp> {
  late final ContactListCubit _contactListCubit;
  late final UserCubit _userCubit;

  @override
  void initState() {
    super.initState();
    _contactListCubit = ContactListCubit();
    _userCubit = UserCubit();
    _userCubit.loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _contactListCubit),
        BlocProvider.value(value: _userCubit),
      ],
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          final isDarkMode = userState is UserLoaded && userState.user.setting?.isDarkMode == true;
          return MaterialApp.router(
            routerConfig: router,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
              scaffoldBackgroundColor: kWhiteColor,
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData.dark(
              useMaterial3: true,
            ).copyWith(
              colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
              scaffoldBackgroundColor: kDarkColor,
            ),
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}
