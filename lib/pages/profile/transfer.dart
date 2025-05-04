// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forms_validate/show_dialog/alert_dialog.dart';
import 'package:http/http.dart' as http;

class Transfer extends StatefulWidget {
  const Transfer({super.key});

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  final formKey = GlobalKey<FormState>();

  TextEditingController recipientUsernameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  bool isSuccess = false;
  late String fullname;
  late String senderUsername;
  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      var args = ModalRoute.of(context)!.settings.arguments as Map;
      senderUsername = args['username'];
    }
    super.didChangeDependencies();
  }

  Future getUser() async {
    var url = Uri.parse(
      "https://ayosdata.com.ng/backend/getUserforTransfer.php",
    );
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'senderUsername': recipientUsernameController.text}),
    );
    debugPrint(response.body);
    var responseBody = jsonDecode(response.body);

    // Navigator.of(context).pop();
    if (response.statusCode == 200 && responseBody['status'] == true) {
      setState(() {
        fullname = responseBody['data'];
        isSuccess = true;
      });
    } else {
      CustomDialogs2.showErrorDialog(context, message: responseBody['message']);
    }
  }

  Future fundUser() async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    var url = Uri.parse("https://ayosdata.com.ng/backend/fundUser.php");
    var response = await http
        .post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'senderUsername': senderUsername,
            'recipientUsername': recipientUsernameController.text,
            'amount': amountController.text,
            'note': noteController.text,
          }),
        )
        .timeout(const Duration(seconds: 20));
    debugPrint(response.body);

    var responseBody = jsonDecode(response.body);
    Navigator.of(context).pop();
    if (response.statusCode == 200 && responseBody['status'] == true) {
      CustomDialogs.showSuccessDialog(
        context,
        message: responseBody['message'],
      );
    } else {
      CustomDialogs2.showErrorDialog(context, message: responseBody['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Username",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * 0.5,
                    child: TextFormField(
                      controller: recipientUsernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: getUser,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              if (isSuccess) ...[
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              width: MediaQuery.of(context).size.width * 0.9,
                              // height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey,
                                // shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(blurRadius: 1, color: Colors.black),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      fullname[0].toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        fullname,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "@${recipientUsernameController.text}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Amount",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 4),
                          TextFormField(
                            controller: amountController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: "Enter amount",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Description",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 4),
                          TextFormField(
                            controller: noteController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Write short note",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black,
                            ),
                            child: InkWell(
                              onTap: fundUser,
                              child: Center(
                                child: Text(
                                  "Transfer",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
