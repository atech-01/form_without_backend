// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:forms_validate/show_dialog/alert_dialog.dart';
import 'package:http/http.dart' as http;

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  late List<TextEditingController> oldPinController;
  late List<TextEditingController> newPinController;
  bool isEnteringOldPin = true;
  String oldPin = '';
  String newPin = '';

  void clearPin() {
    oldPin = '';
    newPin = '';
    for (var controller in oldPinController) {
      controller.clear();
    }
    for (var controller in newPinController) {
      controller.clear();
    }
    setState(() {
      isEnteringOldPin = true;
    });
  }

  void _onNumberTap(String number) {
    setState(() {
      if (oldPin.length < 4) {
        oldPin += number;
        oldPinController[oldPin.length - 1].text = number;
        if (oldPin.length == 4) {
          isEnteringOldPin = false;
        }
      } else {
        if (newPin.length < 4) {
          newPin += number;
          newPinController[newPin.length - 1].text = number;
          if (newPin.length == 4) {
            changePin().then((_) {
              clearPin();
            });
          }
        }
      }
    });
  }

  void _onBackspace() {
    setState(() {
      if (!isEnteringOldPin && newPin.isNotEmpty) {
        newPinController[newPin.length - 1].clear();
        newPin = newPin.substring(0, newPin.length - 1);
      } else if (!isEnteringOldPin && oldPin.isNotEmpty) {
        oldPinController[oldPin.length - 1].clear();
        oldPin = oldPin.substring(0, oldPin.length - 1);
      }
    });
  }

  late String username;
  late String fullname;
  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      var args = ModalRoute.of(context)!.settings.arguments as Map;
      username = args['username'];
      fullname = args['fullname'];
    }
    super.didChangeDependencies();
  }

  Future changePin() async {
    var url = Uri.parse('https://ayosdata.com.ng/backend/changePin.php');
    var response = await http
        .post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'username': username,
            'oldPin': oldPin,
            'newPin': newPin,
          }),
        )
        .timeout(Duration(seconds: 2));

    debugPrint(response.body);

    var responseBody = jsonDecode(response.body);

    if (response.statusCode == 200 && responseBody['status'] == true) {
      CustomDialogs.showSuccessDialog(
        context,
        message: responseBody['message'],
        onOkay: () {
          Navigator.pop(context);
        },
      );
    } else {
      CustomDialogs2.showErrorDialog(
        context,
        message: responseBody['message'],
        // onOkay: () {
        //   Navigator.pop(context);
        // },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    oldPinController = List.generate(4, (_) => TextEditingController());
    newPinController = List.generate(4, (_) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/atech.png'),
                    ),
                  ),
                ),
                // SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(right: 2),
                  child: Text(
                    "Welcome, \u{1F44B}",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    fullname,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                // Padding(
                //   padding: EdgeInsets.only(right: 30),
                //   child: Text(
                //     "Welcome, \u{1F44B}",
                //     style: TextStyle(
                //       fontSize: 24,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // SizedBox(height: 5),
                // Padding(
                //   padding: EdgeInsets.only(left: 12),
                //   child: Text(
                //     fullname,
                //     style: TextStyle(
                //       fontSize: 24,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                //   ],
                // ),
                SizedBox(height: 15),
                Text(
                  isEnteringOldPin
                      ? "Enter your Old PIN"
                      : "Enter your new PIN",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: Center(
                        child: TextFormField(
                          controller:
                              isEnteringOldPin
                                  ? oldPinController[index]
                                  : newPinController[index],
                          obscureText: true,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            counterText: "",
                            isCollapsed: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          style: TextStyle(fontSize: 18, color: Colors.yellow),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 40),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    if (index == 11) {
                      return _buildBackspaceButton();
                    } else if (index == 9) {
                      return SizedBox();
                    } else {
                      return _buildNumberButton(
                        (index == 10) ? '0' : '${index + 1}',
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return TextButton(
      onPressed: () => _onNumberTap(number),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(5),
        // backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
      ),
      child: Text(number, style: TextStyle(fontSize: 24)),
    );
  }

  Widget _buildBackspaceButton() {
    return TextButton(
      onPressed: _onBackspace,
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        // backgroundColor: Colors.red,
        foregroundColor: Colors.blue,
      ),
      child: Icon(Icons.backspace, size: 24),
    );
  }

  // Widget _buildSubmitButton() {
  //   return ElevatedButton(
  //     onPressed: changePin,
  //     style: ElevatedButton.styleFrom(
  //       shape: CircleBorder(),
  //       padding: EdgeInsets.all(20),
  //       backgroundColor: Colors.green,
  //       foregroundColor: Colors.white,
  //     ),
  //     child: Icon(Icons.check, size: 24),
  //   );
  // }
}
