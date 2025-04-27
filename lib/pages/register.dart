import 'package:flutter/material.dart';
// import 'package:forms_validate/pages/login.dart';
// import 'package:forms_validate/pages/router.dart';
// import 'package:forms_validate/pages/router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RegExp emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  bool _obscureText = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Sign Up",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: usernameController,
                      // obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter Username",
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field can't be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter your Fullname",
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Field can't be empty";
                        } else if (!RegExp(
                          r'^[A-Za-z]+(?: [A-Za-z]+)+$',
                        ).hasMatch(value.trim())) {
                          return "Please enter your full name (e.g., John Moses)";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 30),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter your Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (emailRegex.hasMatch(value!)) {
                        } else if (value.isEmpty) {
                          return "Field can't be empty";
                        } else {
                          return "Email is not correctly formatted";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter your Phone number",
                        prefixIcon: Icon(Icons.contacts),
                      ),
                      validator: (value) {
                        if (value!.length != 11) {
                          return "Phone Number must be 11 digit";
                        } else if (value.isEmpty) {
                          return "Field can't be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
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
                      validator: (value) {
                        if (value!.length < 5) {
                          return "Password must be at least 5 characters";
                        } else if (value.isEmpty) {
                          return "Field can't be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20),

                    InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  contentPadding: EdgeInsets.all(20),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 60,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Success",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Account Profile Updated Successfully!",
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 20),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/login',
                                            arguments: {
                                              'fullname':
                                                  fullNameController.text,
                                              'username':
                                                  usernameController.text,
                                              'email': emailController.text,
                                              'password':
                                                  passwordController.text,
                                            },
                                          );
                                        },
                                        child: Text(
                                          "Okay",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          );
                        }
                      },

                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: InkWell(
                        onTap: () {
                          debugPrint("Hello world");
                          // Navigator.pushNamed(context, AppRoutes.login);
                        },
                        child: Text("Already has an account?"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
