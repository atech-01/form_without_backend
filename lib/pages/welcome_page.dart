import 'package:flutter/material.dart';
import 'package:forms_validate/pages/router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                ),
              ),
            ),
            Text("Transact with ease"),
            SizedBox(height: size.height * 0.30),
            Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                "ATECH",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Digital Connectivity in your finger tip!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Buy Airtime, Top up Data, Pay bill or subscribe cables",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  Center(
                    child: Text(
                      "with ease and comfort",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 80),
            Container(
              width: size.width * 0.9,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black,
              ),
              child: Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.register);
                  },
                  child: Text(
                    "Create an Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            // Center(
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.pushNamed(context, '/login');
            //     },
            //     child: Text("Already has an account?"),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
