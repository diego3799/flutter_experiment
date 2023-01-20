import 'package:flutter/material.dart';
import 'package:fun_experiment/provider/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String path = "/";
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(context.read<UserProvider>().jwt));
  }
}
