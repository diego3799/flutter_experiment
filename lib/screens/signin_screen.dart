import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fun_experiment/provider/user_provider.dart';
import 'package:fun_experiment/screens/home_routes/home_screen.dart';
import 'package:fun_experiment/screens/signup_screen.dart';
import 'package:fun_experiment/utils/form_utils.dart';
import 'package:fun_experiment/utils/env_vars.dart';
import 'package:fun_experiment/utils/notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:toasta/toasta.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  static String path = "/signin";
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();

  void login(BuildContext context) async {
    setState(() {
      loading = true;
    });
    try {
      var url = Uri.http(backendUrl, "/api/users/signin");
      var response = await http.post(url, body: {
        "email": email,
        "password": password,
      });

      var body = jsonDecode(response.body);
      if (body["success"] == false) {
        if (mounted) {
          setNotification(context,
              title: "Error",
              subtitle: body["message"],
              status: ToastStatus.failed);
        }
      } else {
        if (mounted) {
          //  Set jwt
          context.read<UserProvider>().setUserJwt(body["jwt"]);
          setNotification(context,
              title: "Login successful", status: ToastStatus.success);
          context.go(HomeScreen.path);
        }
      }
    } catch (e) {
      setNotification(context,
          title: "Error",
          subtitle: "There was an unexpected error, try again.",
          status: ToastStatus.failed);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  bool loading = false;
  bool hidePassword = true;
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Fun app",
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                    validator: emailValidator,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            icon: Icon(
                              hidePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey[500],
                            ))),
                    onChanged: (value) {
                      password = value;
                    },
                    validator: notEmptyValidator,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: loading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          login(context);
                        }
                      },
                child: loading
                    ? const SpinKitCircle(
                        color: Colors.white,
                        size: 20,
                      )
                    : const Text("Login")),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                context.go(SignupScreen.path);
              },
              child: Text(
                "I don't have an account",
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
      )),
    );
  }
}
