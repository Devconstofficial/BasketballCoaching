import 'package:basketball_coaching/Screens/Coach/coach_navbar.dart';
import 'package:basketball_coaching/Screens/login.dart';
import 'package:basketball_coaching/models/user.dart';
import 'package:basketball_coaching/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/Players/players_navbar.dart';

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  late LocalUser? localUser;

  Future<LocalUser?> getLocalUser() async {
    final UserAuthProvider authProvider =
        Provider.of<UserAuthProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    String? username = prefs.getString('user_name');
    String? userType = prefs.getString('user_type');
    if (userId != null && username != null && userType != null) {
      LocalUser user = LocalUser(id: userId, name: username, type: userType);
      return user;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    localUser = await getLocalUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final UserAuthProvider authProvider =
        Provider.of<UserAuthProvider>(context, listen: false);
    print(
        "USER AUTH \n\n ${authProvider.userId} \n\n ${authProvider.userName} \n\n ${authProvider.userType.toString()}");
    return FutureBuilder<LocalUser?>(
      future: getLocalUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          localUser = snapshot.data;
          if (localUser != null) {
            print(
                "USER AUTH \n\n ${authProvider.userId} \n\n ${authProvider.userName} \n\n ${authProvider.userType.toString()}");
            String id = (localUser!.type == 'coach') ? 'coach' : 'student';
            if (id == 'coach') {
              return const CoachNavBar();
            } else if (id == 'student') {
              return PlayerNavBar(
                userId: localUser!.id,
              );
            }
          }
        }

        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              User? user = snapshot.data;
              if (user == null) {
                return const LoginScreen();
              } else {
                return const CoachNavBar();
              }
            }
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        );
      },
    );
  }
}
