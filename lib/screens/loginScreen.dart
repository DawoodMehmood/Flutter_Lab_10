import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profileModel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Navigate directly to home screen if user logged in
    Timer(const Duration(), () async {
      final sharedPrefs = await SharedPreferences.getInstance();
      final isLoggedIn = sharedPrefs.getBool('isLoggedIn') ?? false;
      final email = sharedPrefs.getString('email');
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(
          context,
          '/profile',
          arguments: ProfileInfo(
            "Dawood Mehmood",
            "profile.png",
            "090078601",
            email!,
            true,
            "NUST H-12, Islamabad",
          ),
        );
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  bool _obscurePass = true;
  bool _value = false;
  String email = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 64,
                  backgroundImage: AssetImage("assets/logo.png"),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  // add email validation through regex
                  validator: (value) {
                    String? error;
                    if (value == null || value.isEmpty) {
                      error = "Email cannot be empty";
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      error = "Invalid Email";
                    }
                    if (error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error)),
                      );
                    } else {
                      email = value!;
                    }

                    return error;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.mail,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  // add password validation through regex
                  validator: (value) {
                    String? error;
                    if (value == null || value.isEmpty) {
                      error = "Password cannot be empty";
                    } else if (!RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                        .hasMatch(value)) {
                      error =
                          "Password must have a digit, a uppercase letter,a special character and >8 length";
                    }
                    if (error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error)),
                      );
                    }

                    return error;
                  },
                  obscureText: _obscurePass,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () => {
                        setState(() => {_obscurePass = !_obscurePass}),
                      },
                      icon: Icon(
                        _obscurePass ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            value: _value,
                            onChanged: (bool? val) async {
                              // using shared preferences to set isLoggedIn value
                              final sharedPrefs =
                                  await SharedPreferences.getInstance();
                              sharedPrefs.setBool('isLoggedIn', val!);

                              setState(() => {_value = val});
                            }),
                        const Text("Remember me"),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password",
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Continue if form is valid
                    if (_formKey.currentState!.validate()) {
                      // using shared preferences to set email
                      final sharedPrefs = await SharedPreferences.getInstance();
                      sharedPrefs.setString('email', email);
                      // using data transfer object ProfileInfo to send data to the next page
                      Navigator.pushNamed(context, '/profile',
                          arguments: ProfileInfo(
                              "Dawood Mehmood",
                              "profile.png",
                              "090078601",
                              email!,
                              true,
                              "NUST H-12, Islamabad"));
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
