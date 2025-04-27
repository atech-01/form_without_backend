import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String username;
  final String fullname;
  final String email;

  Profile({
    super.key,
    required this.email,
    required this.fullname,
    required this.username,
  });

  final List<Map<String, dynamic>> profile = [
    {
      "title": "Edit Profile",
      "subtitle": "Personal info, name, etc",
      "icon": Icons.edit,
      "route": '/edit_profile', // Add a route to navigate to
    },
    {
      "title": "Security",
      "subtitle": "Passwords, change pin",
      "icon": Icons.lock,
      "route": '/security',
    },
    {
      "title": "Sign Out",
      "subtitle": "Sign out of your account",
      "icon": Icons.exit_to_app,
      "route": '/sign_out', // Add a route to navigate to
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), backgroundColor: Colors.black),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      fullname[0].toUpperCase(),
                      style: TextStyle(color: Colors.green, fontSize: 40),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  fullname.toUpperCase(),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "@$username",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
                SizedBox(height: 10),
                Text(
                  email,
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(height: 12),

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: profile.length,
                  itemBuilder: (context, index) {
                    return _cardItem(
                      profile[index]['title'],
                      profile[index]['subtitle'],
                      profile[index]['icon'],
                      onTap: () {
                        if (profile[index]['route'] == '/edit_profile') {
                          Navigator.pushNamed(
                            context,
                            profile[index]['route'],
                            arguments: {
                              'fullname': fullname,
                              'username': username,
                              'email': email,
                            },
                          );
                        } else {
                          Navigator.pushNamed(context, profile[index]['route']);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _cardItem(
  String title,
  String subtitle,
  IconData icon, {
  required VoidCallback onTap,
}) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    child: ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 14)),
      onTap: onTap,
    ),
  );
}
