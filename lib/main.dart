import 'package:basketball_coaching/Screens/splash_screen.dart';
import 'package:basketball_coaching/cubits/chat/cubit.dart';
import 'package:basketball_coaching/cubits/performance/cubit.dart';
import 'package:basketball_coaching/cubits/students/cubit.dart';
import 'package:basketball_coaching/cubits/videos/cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import './firebase_options.dart';
import 'providers/coach_provider.dart';
import 'providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            BlocProvider<StudentCubit>(
              create: (context) => StudentCubit(),
            ),
            BlocProvider<VideoCubit>(
              create: (context) => VideoCubit(),
            ),
            BlocProvider<PerformanceCubit>(
              create: (context) => PerformanceCubit(),
            ),
            BlocProvider<MessagesCubit>(
              create: (context) => MessagesCubit(),
            ),
            ChangeNotifierProvider<CoachProvider>(
              create: (context) => CoachProvider(),
            ),
            ChangeNotifierProvider<UserAuthProvider>(
              create: (context) => UserAuthProvider(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'My App',
            home: child,
          ),
        );
      },
      child: const SplashScreen(),
    );
  }
}
