import 'package:flutter/material.dart';
import 'package:fun_experiment/screens/signin_screen.dart';
import 'package:fun_experiment/utils/form_utils.dart';
import 'package:go_router/go_router.dart';

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
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                    validator: emailValidator,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Password"),
                    onChanged: (value) {
                      password = value;
                    },
                    validator: notEmptyValidator,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Confirm password"),
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
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("Form validated");
                    print("$email $password $confirmPassword");
                  }
                },
                child: Text("Create account")),
            SizedBox(
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
