import 'package:flutter/material.dart';

class Airtime extends StatefulWidget {
  const Airtime({super.key});

  @override
  State<Airtime> createState() => _AirtimeState();
}

class _AirtimeState extends State<Airtime> {
  final formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List<String> net = ["MTN", "AIRTEL", "GLO", "9MOBILE"];

  List<String> type = ["VTU", "SNS"];

  String? selectedNetwork;
  String? selectedType;

  @override
  void initState() {
    super.initState();
    selectedNetwork = net[0];
    selectedType = type[0];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Airtime Topup"))),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.1),
                // Dropdown for Network Selection
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Select Network",
                  ),
                  value: selectedNetwork,
                  items:
                      net.map((network) {
                        return DropdownMenuItem<String>(
                          value: network,
                          child: Text(network),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedNetwork = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a network";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "",
                  ),
                  value: selectedType,
                  items:
                      type.map((type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),

                  onChanged: (value) {
                    setState(() {
                      selectedType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a plan";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Phone Number",
                    prefixIcon: Icon(Icons.contacts),
                  ),
                  validator: (value) {
                    if (value!.length != 11) {
                      return "Phone Number must be 11 digit";
                    } else if (value.isEmpty) {
                      return "Phone number can't be empty";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Amount",
                    // prefixIcon: Icon(Icons.contacts),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Amount can't be empty";
                    }
                    final amount = double.tryParse(value);

                    if (amount == null || amount < 100) {
                      return "Amount must be at least 100";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),

                GestureDetector(
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
                                    "Artime of ₦${amountController.text} has been sent to ${phoneController.text}",
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
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
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Buy Data",
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
