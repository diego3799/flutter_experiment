import 'dart:async';
import 'package:fun_experiment/provider/user_provider.dart';
import 'package:fun_experiment/screens/home_routes/home_screen.dart';
import 'package:fun_experiment/screens/signin_screen.dart';
import 'package:fun_experiment/screens/signup_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  static String path = "/loading";

  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().loadVars().then((_) {
      if (context.read<UserProvider>().jwt != null) {
        return context.go(HomeScreen.path);
      }
      return context.go(SigninScreen.path);
    }).catchError((_) {
      return context.go(SigninScreen.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.green,
          size: 70,
        ),
      ),
    );
  }
}
