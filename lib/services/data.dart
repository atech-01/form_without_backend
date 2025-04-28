import 'package:flutter/material.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  final formKey = GlobalKey<FormState>();
  TextEditingController networkController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List<String> net = ["MTN", "AIRTEL", "GLO", "9MOBILE"];

  Map<String, List<String>> plansByNetwork = {
    "MTN": ["SME", "SME2", "GIFTING", "CORPORATE-GIFTING"],
    "AIRTEL": ["GIFTING", "CORPORATE-GIFTING"],
    "GLO": ["GIFTING"],
    "9MOBILE": ["GIFTING"],
  };

  String? selectedNetwork;
  String? selectedPlan;

  @override
  Widget build(BuildContext context) {
    List<String> availablePlan =
        selectedNetwork != null ? plansByNetwork[selectedNetwork] ?? [] : [];
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  labelText: "Select Data plan",
                ),
                value: selectedNetwork,
                items:
                    availablePlan.map((planVolume) {
                      return DropdownMenuItem<String>(
                        value: selectedPlan,
                        child: Text(planVolume),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedNetwork = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select a data_plan";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Select the plan volume",
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
                    return "Select the plan volume";
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
                  labelText: "Enter your Phone number",
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
                                  "Data has been sent Successfully",
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
                                    // Navigator.pushNamed(
                                    //   context,
                                    //   '/login',
                                    //   arguments: {
                                    //     'fullname': fullNameController.text,
                                    //     'username': usernameController.text,
                                    //     'email': emailController.text,
                                    //     'password': passwordController.text,
                                    //   },
                                    // );
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
    );
  }
}
