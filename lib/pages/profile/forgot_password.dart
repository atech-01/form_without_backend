// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forms_validate/pages/router.dart';
import 'package:forms_validate/show_dialog/alert_dialog.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  Future verifyEmail() async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    var url = Uri.parse("https://ayosdata.com.ng/backend/emailVerify.php");
    debugPrint(emailController.text);
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'email': emailController.text}),
    );
    debugPrint(response.body);
    var responseBody = jsonDecode(response.body);
    Navigator.of(context).pop();
    if (response.statusCode == 200 && responseBody['status'] == true) {
      await CustomDialogs.showSuccessDialog(
        context,
        message: responseBody['message'],
      );
      Navigator.pushNamed(context, AppRoutes.login);
    } else {
      CustomDialogs2.showErrorDialog(context, message: responseBody['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expanded(child: Container()),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Email Adress",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: SizedBox(
              width: size.width * 0.9,
              child: TextFormField(
                controller: emailController,
                showCursor: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.alternate_email),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(left: 30, right: 50),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
            ),
            child: InkWell(
              onTap: verifyEmail,
              child: Center(
                child: Text(
                  "Verify Email",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
