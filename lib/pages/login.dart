// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forms_validate/pages/router.dart';
import 'package:forms_validate/show_dialog/alert_dialog.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late String username;
  late String password;

  Future login() async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    var url = Uri.parse('https://ayosdata.com.ng/backend/login.php');

    var response = await http
        .post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'username': usernameController.text,
            'password': passwordController.text,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint(response.body);
    var responseData = jsonDecode(response.body);

    Navigator.of(context).pop();

    if (response.statusCode == 200 && responseData['status'] == true) {
      var userId = responseData['user_id'];
      Navigator.pushNamed(
        context,
        AppRoutes.home,
        arguments: {'user_id': userId},
      );
    } else {
      CustomDialogs2.showErrorDialog(context, message: responseData['message']);
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(SnackBar(content: Text(responseData['message'])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Username",
                  prefixIcon: Icon(Icons.alternate_email),
                ),
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return "Field can't be empty";
                //   } else {
                //     return null;
                //   }
                // },
              ),
              SizedBox(height: 30),

              TextFormField(
                keyboardType: TextInputType.text,
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter your Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText == false
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                // validator: (value) {
                //   if (value!.length < 5) {
                //     return "Password must be at least 5 characters";
                //   } else if (value.isEmpty) {
                //     return "Field can't be empty";
                //   } else {
                //     return null;
                //   }
                // },
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: login,
                //  () {
                //   if (formKey.currentState!.validate()) {}
                // },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Center(
                child: InkWell(
                  onTap: () {
                    // debugPrint("Hello world");
                    Navigator.pushNamed(context, "/register");
                  },
                  child: Text("Don't have an account yet?"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
