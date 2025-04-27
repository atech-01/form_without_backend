import 'package:flutter/material.dart';
import 'package:forms_validate/pages/history.dart';
import 'package:forms_validate/pages/home.dart';
import 'package:forms_validate/pages/profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late String username;
  late String fullname;
  late String email;
  int selectedItem = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    fullname = args['fullname'];
    username = args['username'];
    email = args['email'];
  }

  void _onTapItem(int index) {
    setState(() {
      selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> appScreen = [
      HomePage(username: username, fullname: fullname),
      const History(),
      Profile(username: username, fullname: fullname, email: email),
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
