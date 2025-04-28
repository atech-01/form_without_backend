import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Needed for Clipboard

class Fund extends StatelessWidget {
  const Fund({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Container(
              width: size.width * 0.85,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Palmpay",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple, // Or any nice color
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Account Name:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Atopup", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Account Number Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2, // 2 parts for label
                        child: Text(
                          "Account No:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3, // 3 parts for number + copy button
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("9068040801", style: TextStyle(fontSize: 18)),
                            SizedBox(width: 5),
                            IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(text: "9068040801"),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Account number copied"),
                                  ),
                                );
                              },
                              icon: Icon(Icons.copy, size: 20),
                              padding:
                                  EdgeInsets.zero, // remove default padding
                              constraints:
                                  BoxConstraints(), // remove default constraint
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: size.width * 0.85,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "GTBANK",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple, // Or any nice color
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Account Name:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Abd", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Account Number Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2, // 2 parts for label
                        child: Text(
                          "Account No:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3, // 3 parts for number + copy button
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("0435189908", style: TextStyle(fontSize: 18)),
                            SizedBox(width: 5),
                            IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(text: "0435189908"),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Account number copied"),
                                  ),
                                );
                              },
                              icon: Icon(Icons.copy, size: 20),
                              padding:
                                  EdgeInsets.zero, // remove default padding
                              constraints:
                                  BoxConstraints(), // remove default constraint
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
