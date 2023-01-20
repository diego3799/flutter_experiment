import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fun_experiment/provider/user_provider.dart';
import 'package:fun_experiment/screens/home_routes/home_screen.dart';
import 'package:fun_experiment/screens/signin_screen.dart';
import 'package:fun_experiment/utils/env_vars.dart';
import 'package:fun_experiment/utils/form_utils.dart';
import 'package:fun_experiment/utils/notifications.dart';
import 'package:go_router/go_router.dart';
import "package:http/http.dart" as http;
import 'package:toasta/toasta.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static var path = "/signup";

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String confirmPassword = "";
  bool hidePassword = true;
  bool loading = false;

  void createAccount(BuildContext context) async {
    setState(() {
      loading = true;
    });
    try {
      var url = Uri.http(backendUrl, "/api/users/signup");
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
              title: "Account created", status: ToastStatus.success);
          context.go(HomeScreen.path);
        }
      }
    } catch (e) {
      print(e);
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                        hintText: "Confirm password",
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
                      confirmPassword = value;
                    },
                    validator: ((value) {
                      var notEmpty = notEmptyValidator(value);
                      if (notEmpty != null) {
                        return notEmpty;
                      }
                      if (value != password) {
                        return "Verification don't match";
                      }
                    }),
                  )
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
                          createAccount(context);
                        }
                      },
                child: loading
                    ? const SpinKitCircle(
                        color: Colors.white,
                        size: 20,
                      )
                    : const Text("Create account")),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                context.go(SigninScreen.path);
              },
              child: Text(
                "Already have an account",
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
