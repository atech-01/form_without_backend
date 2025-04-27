import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late String fullname;
  late String username;
  late String email;

  late TextEditingController fullnameController;
  late TextEditingController usernameController;
  late TextEditingController emailController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    fullname = args['fullname'];
    username = args['username'];
    email = args['email'];

    // Initialize the controllers with the current values
    fullnameController = TextEditingController(text: fullname);
    usernameController = TextEditingController(text: username);
    emailController = TextEditingController(text: email);
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    fullnameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Center(child: Text("Edit Profile")),
        // backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70),
                TextFormField(
                  controller: fullnameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // Username Field
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // Email Field
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 30),

                // Save Button
                GestureDetector(
                  onTap: () {
                    // Get the updated values from the controllers
                    String updatedFullname = fullnameController.text;
                    String updatedUsername = usernameController.text;
                    String updatedEmail = emailController.text;

                    // Optionally, pop the EditProfile screen
                    Navigator.pop(context, {
                      'fullname': updatedFullname,
                      'username': updatedUsername,
                      'email': updatedEmail,
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Save Changes",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
