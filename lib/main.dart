import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fun_experiment/buttomNavigator.dart';
import 'package:fun_experiment/provider/user_provider.dart';
import 'package:fun_experiment/screens/home_routes/home_screen.dart';
import 'package:fun_experiment/screens/loading_screen.dart';
import 'package:fun_experiment/screens/signin_screen.dart';
import 'package:fun_experiment/screens/signup_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toasta/toasta.dart';

void main() async {
  await dotenv.load();
  return runApp(const MyApp());
}

final _router = GoRouter(initialLocation: SigninScreen.path, routes: [
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
    return ToastaContainer(
      child: MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
          theme: ThemeData.dark().copyWith(
              inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: Colors.white,
                  alignLabelWithHint: false,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  hintStyle: TextStyle(
                      color: Colors.grey[500],
                      decorationStyle: TextDecorationStyle.solid),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 2)),
                  errorStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  counterStyle: const TextStyle(color: Colors.amber)),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      shape: const StadiumBorder(),
                      elevation: 10,
                      padding: const EdgeInsets.symmetric(vertical: 20))),
              textTheme: TextTheme(
                  subtitle1: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 17),
                  subtitle2: TextStyle(color: Colors.blue[300]),
                  headline1: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ))),
        ),
      ),
    );
  }
}
