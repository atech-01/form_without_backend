import 'package:flutter/material.dart';
// import 'package:forms_validate/pages/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  final String username;
  final String fullname;

  const HomePage({super.key, required this.username, required this.fullname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xFFFE2394),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          fullname[0].toUpperCase(),
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullname,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "@$username",
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Total balance",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₦400",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Service Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildServiceTile(Icons.add, "Fund", Colors.amber, () {
                  Navigator.pushNamed(context, "/fund");
                }),
                _buildServiceTile(Icons.phone, "Airtime", Colors.blue, () {
                  Navigator.pushNamed(context, "/airtime");
                }),
                _buildServiceTile(Icons.wifi, "Data", Colors.green, () {
                  Navigator.pushNamed(context, "/data");
                }),
                _buildServiceTile(Icons.receipt, "Cable", Colors.orange, () {
                  Navigator.pushNamed(context, "/cable");
                }),
                _buildServiceTile(
                  Icons.flash_on,
                  "Electricity",
                  Colors.purple,
                  () {
                    Navigator.pushNamed(context, "/bill");
                  },
                ),
                _buildServiceTile(Icons.send, "Transfer", Colors.redAccent, () {
                  Navigator.pushNamed(context, "/transfer");
                }),
                _buildServiceTile(Icons.message, "Bulk SMS", Colors.pink, () {
                  Navigator.pushNamed(context, "/bsm");
                }),
                _buildServiceTile(Icons.more_horiz, "More", Colors.indigo, () {
                  Navigator.pushNamed(context, "/more");
                }),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'Transaction',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              itemCount: 20,
              itemBuilder: (context, index) {
                return _cardItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _cardItem() {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    child: ListTile(
      leading: Icon(Icons.warning, color: Colors.green),
      title: Text("Debit"),
      subtitle: Text("data"),
    ),
  );
}

Widget _buildServiceTile(
  IconData icon,
  String label,
  Color color,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
