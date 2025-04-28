import 'package:flutter/material.dart';
// import 'package:forms_validate/pages/router.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  final formKey = GlobalKey<FormState>();
  // TextEditingController networkController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List<String> net = ["MTN", "AIRTEL", "GLO", "9MOBILE"];

  Map<String, Map<String, List<Map<String, String>>>> plansByNetwork = {
    "MTN": {
      "SME": [
        {"volume": "1GB", "price": "₦240"},
        {"volume": "2GB", "price": "₦480"},
      ],
      "SME2": [
        {"volume": "500MB", "price": "₦150"},
        {"volume": "1.5GB", "price": "₦360"},
      ],
      "GIFTING": [
        {"volume": "500MB", "price": "₦300"},
        {"volume": "1GB", "price": "₦600"},
      ],
      "CORPORATE-GIFTING": [
        {"volume": "1GB", "price": "₦500"},
        {"volume": "2GB", "price": "₦1000"},
      ],
    },
    "AIRTEL": {
      "GIFTING": [
        {"volume": "1GB", "price": "₦500"},
        {"volume": "2GB", "price": "₦1000"},
      ],
      "CORPORATE-GIFTING": [
        {"volume": "1GB", "price": "₦450"},
        {"volume": "2GB", "price": "₦900"},
      ],
    },
    "GLO": {
      "GIFTING": [
        {"volume": "1GB", "price": "₦400"},
        {"volume": "2GB", "price": "₦800"},
      ],
    },
    "9MOBILE": {
      "GIFTING": [
        {"volume": "1GB", "price": "₦500"},
        {"volume": "2GB", "price": "₦950"},
      ],
    },
  };

  String? selectedNetwork;
  String? selectedPlan;
  String? selectedVolume;
  Map<String, String>? selectedPrice;

  @override
  void initState() {
    super.initState();
    selectedNetwork = net[0];
    selectedPlan = plansByNetwork[selectedNetwork]!.keys.first;
    selectedVolume =
        plansByNetwork[selectedNetwork]?[selectedPlan]?[0]['volume'];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<Map<String, String>> availablePrices =
        selectedNetwork != null && selectedPlan != null
            ? (plansByNetwork[selectedNetwork]?[selectedPlan] ?? [])
            : [];

    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Data Purchase"))),
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
                      selectedPlan = null;
                      selectedPrice = null;
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

                // Dropdown for Plan Selection
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Select Data plan",
                  ),
                  value: selectedPlan,
                  items:
                      selectedNetwork != null
                          ? plansByNetwork[selectedNetwork]!.keys.map((plan) {
                            return DropdownMenuItem<String>(
                              value: plan,
                              child: Text(plan),
                            );
                          }).toList()
                          : [],
                  onChanged: (value) {
                    setState(() {
                      selectedPlan = value;
                      selectedPrice = null; // Reset price when plan changes
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

                // Dropdown for Price Selection
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Select Price",
                  ),
                  value: selectedPrice != null ? selectedPrice!['price'] : null,
                  items:
                      availablePrices.map((price) {
                        return DropdownMenuItem<String>(
                          value: price['price'],
                          child: Text("${price['volume']} @ ${price['price']}"),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPrice = availablePrices.firstWhere(
                        (price) => price['price'] == value,
                        orElse: () => {},
                      );
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a price";
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
                                    "$selectedNetwork $selectedPlan $selectedVolume Data has been sent to ${phoneController.text} Succesfully",
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
