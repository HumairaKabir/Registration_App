import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled3/loginScreen.dart';

const String registrationApiUrl = 'http://172.16.22.81:4220/api/Registration/UserRegistration';
// Registration API URL

void main() {
  runApp(
    MaterialApp(
      home: RegScreen(),
    ),
  );
}

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  String selectedGender = 'Male';
  // Default gender

  DateTime? selectedDate;
  // Selected date for Date of Birth

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1700),
      lastDate: DateTime.now(),
    ))!;

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  bool obscurePassword = true;
  // To hide/show password
  bool obscureConfirmPassword = true;
  // To hide/show confirm password

  String confirmPassword = '';
  // Store confirm password input
  String errorText = '';
  // Error text for password matching

  void _onPasswordChanged(String newPassword) {
    setState(() {
      confirmPassword = newPassword;
      if (newPassword != _passwordController.text) {
        errorText = "Passwords do not match";
      } else {
        errorText = '';
      }
    });
  }

  final TextEditingController _passwordController = TextEditingController();

  // Function to perform user registration
  Future<void> registerUser(BuildContext context) async {
    try {
      final Map<String, dynamic> registrationData = {
        "Name": "UserName",
        // Replace with the user's name
        "GenderId": selectedGender,
        "Dob": selectedDate != null
            ? "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}"
            : "",
        "MobileNo": "01789001135",
        // Replace with the user's mobile number
        "LoginId": "user123",
        // Replace with the user's login ID
        "Password": _passwordController.text,
        "ConfirmPassword": confirmPassword,
      };

      final response = await http.post(
        Uri.parse(registrationApiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(registrationData),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Registration Successful: $responseData');

        if (responseData['errCode'] == 'OK') {
          Fluttertoast.showToast(
            msg: "Registration Successful!, ${responseData['errMessage']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            // Change to your preferred color
            textColor: Colors.black,
            fontSize: 16.0,
          );

          // After successful registration, navigate to the Login screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        } else {
          print('Registration Failed: ${response.body}');
          Fluttertoast.showToast(
            msg: "Registration Failed. ${responseData['errMessage']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white, // Change to your preferred color
            textColor: Colors.black,
            fontSize: 16.0,
          );
        }
      } else {
        print('Registration Failed: ${response.body}');
        Fluttertoast.showToast(
          msg: "Registration Failed. Please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white, // Change to your preferred color
          textColor: Colors.black,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(
        msg: "An error occurred during registration. Please try again later.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        // Change to your preferred color
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xffB81736),
                Color(0xff281537),
              ]),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Create Your\nAccount',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          label: Text(
                            'Full Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736),
                            ),
                          ),
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffB81736),
                          ),
                        ),
                        value: selectedGender,
                        items: ['Male', 'Female', 'Others']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedGender = newValue!;
                          });
                        },
                      ),
                      TextField(
                        onTap: () {
                          _selectDate(context);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Date of Birth',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffB81736),
                          ),
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                          ),
                        ),
                        readOnly: true,
                        controller: TextEditingController(
                          text: selectedDate != null
                              ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                              : "",
                        ),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Phone or Gmail',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffB81736),
                          ),
                        ),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          label: Text(
                            'Login ID',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736),
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            child: Icon(
                              obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffB81736),
                          ),
                        ),
                        controller: _passwordController,
                      ),
                      TextField(
                        obscureText: obscureConfirmPassword,
                        onChanged: _onPasswordChanged,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureConfirmPassword =
                                !obscureConfirmPassword;
                              });
                            },
                            child: Icon(
                              obscureConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                          labelText: 'Confirm Password',
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffB81736),
                          ),
                          errorText: errorText.isNotEmpty ? errorText : null,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 70),
                      Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffB81736),
                              Color(0xff281537),
                            ],
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Call the registerUser function when SIGN UP button is pressed
                            registerUser(context);
                          },
                          child: const Center(
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


