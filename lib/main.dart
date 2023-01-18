import 'package:flutter/material.dart';
import 'package:fun_experiment/buttomNavigator.dart';
import 'package:fun_experiment/screens/home_screen.dart';
import 'package:fun_experiment/screens/loading_screen.dart';
import 'package:fun_experiment/screens/signin_screen.dart';
import 'package:fun_experiment/screens/signup_screen.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(const MyApp());

final _router = GoRouter(initialLocation: SignupScreen.path, routes: [
  GoRoute(
    path: LoadingScreen.path,
    builder: (context, state) => LoadingScreen(),
  ),
  GoRoute(
    path: SignupScreen.path,
    builder: (context, state) => const SignupScreen(),
  ),
  GoRoute(
    path: SigninScreen.path,
    builder: (context, state) => const SigninScreen(),
  ),
  ShellRoute(
    builder: (context, state, child) {
      return ButtomNavigator(child: child);
    },
    routes: [
      GoRoute(
        path: HomeScreen.path,
        builder: (context, state) => const HomeScreen(),
      )
    ],
  )
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData.dark().copyWith(
          inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              alignLabelWithHint: false,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              hintStyle: TextStyle(
                  color: Colors.grey[500],
                  decorationStyle: TextDecorationStyle.solid),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2)),
              errorStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              counterStyle: TextStyle(color: Colors.amber)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 16,
                  ),
                  shape: StadiumBorder(),
                  elevation: 10,
                  padding: EdgeInsets.symmetric(vertical: 20))),
          textTheme: TextTheme(
              subtitle1: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 17),
              subtitle2: TextStyle(color: Colors.blue[300]),
              headline1: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ))),
    );
  }
}
