import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forms_validate/pages/history.dart';
import 'package:forms_validate/pages/home.dart';
import 'package:forms_validate/pages/profile.dart';
import 'package:http/http.dart' as http;

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late String username;
  late String fullname;
  late String email;
  late String phone;
  late int bal;

  int selectedItem = 0;

  Map<String, dynamic>? userData;

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();

  void _onTapItem(int index) {
    setState(() {
      selectedItem = index;
    });
  }

  late int userId;
  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      var args = ModalRoute.of(context)!.settings.arguments as Map;

      userId = int.parse(args['user_id'].toString());

      fetchUserData();
    } else {
      debugPrint("UserId is null");
    }
    super.didChangeDependencies();
  }

  Future fetchUserData() async {
    var url = Uri.parse("https://ayosdata.com.ng/backend/profile.php");

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'user_id': userId}),
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      setState(() {
        userData = decoded;
      });
    } else {
      debugPrint("Failed to fetch user data. Status: ${response.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null || userData!['data'] == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final user = userData!['data'];

    final List<Widget> appScreen = [
      HomePage(
        username: user!['username'],
        fullname: user!['fullname'],
        bal: user!['bal'],
      ),
      const History(),
      Profile(
        username: user!['username'],
        fullname: user!['fullname'],
        email: user!['email'],
      ),
    ];

    return Scaffold(
      body: appScreen[selectedItem],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30), // clip children inside
          child: BottomNavigationBar(
            onTap: _onTapItem,
            currentIndex: selectedItem,
            backgroundColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white54,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history, size: 30),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 30),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
