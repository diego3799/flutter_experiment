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
  bool hidePassword = true;

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
                    obscureText: true,
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("Form validated");
                    print("$email $password $confirmPassword");
                  }
                },
                child: const Text("Create account")),
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
