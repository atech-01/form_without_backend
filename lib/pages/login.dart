import 'package:flutter/material.dart';
// import 'package:forms_validate/pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  RegExp emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  bool _obscureText = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late String fullname;
  late String username;
  late String password;
  late String email;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    fullname = args['fullname'];
    username = args['username'];
    email = args['email'];
    password = args['password'];
  }

  void handleLogin() {
    debugPrint("Username: $username, Password: $password");
    if (usernameController.text == username &&
        passwordController.text == password) {
      Navigator.pushNamed(
        context,
        "/bottom_nav_bar",
        arguments: {'fullname': fullname, 'username': username, 'email': email},
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Invalid username or password',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  hintText: "Enter Username",
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
                keyboardType: TextInputType.text,
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your Password",
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
              GestureDetector(
                onTap: handleLogin,
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
                    debugPrint("Hello world");
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
