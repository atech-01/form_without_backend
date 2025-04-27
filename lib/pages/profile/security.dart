import 'package:flutter/material.dart';

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  final TextEditingController _pinController = TextEditingController();

  String _pin = '';

  void _onNumberTap(String number) {
    setState(() {
      if (_pin.length < 4) {
        _pin += number;
        _pinController.text = _pin;
        if (_pin.length == 4) {
          Future.delayed(Duration(milliseconds: 200));
          _changePin();
        }
      }
    });
  }

  void _onBackspace() {
    setState(() {
      if (_pin.isNotEmpty) {
        _pin = _pin.substring(0, _pin.length - 1);
        _pinController.text = _pin;
      }
    });
  }

  void _changePin() {
    if (_pin.length == 4) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('PIN changed successfully!')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter a 4-digit PIN')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change PIN'), backgroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          children: [
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _pin.length > index ? Colors.black : Colors.transparent,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      _pin.length > index ? _pin[index] : '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),

            // TextFormField(
            //   controller: _pinController,
            //   obscureText: false,
            //   decoration: InputDecoration(
            //     labelText: 'Enter New PIN',
            //     border: OutlineInputBorder(),
            //   ),
            //   readOnly: true,
            // ),
            SizedBox(height: 40),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                if (index == 11) {
                  return _buildBackspaceButton();
                } else if (index == 9) {
                  return SizedBox();
                } else {
                  return _buildNumberButton(
                    (index == 10) ? '0' : '${index + 1}',
                  );
                }
              },
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return ElevatedButton(
      onPressed: () => _onNumberTap(number),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(5),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      child: Text(number, style: TextStyle(fontSize: 24)),
    );
  }

  Widget _buildBackspaceButton() {
    return ElevatedButton(
      onPressed: _onBackspace,
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      child: Icon(Icons.backspace, size: 24),
    );
  }

  // Widget _buildSubmitButton() {
  //   return ElevatedButton(
  //     onPressed: _changePin,
  //     style: ElevatedButton.styleFrom(
  //       shape: CircleBorder(),
  //       padding: EdgeInsets.all(20),
  //       backgroundColor: Colors.green,
  //       foregroundColor: Colors.white,
  //     ),
  //     child: Icon(Icons.check, size: 24),
  //   );
  // }
}
