import 'package:flutter/material.dart';
import 'package:untitled3/dashboard.dart';
import 'package:untitled3/regScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

const String apiUrl = 'http://172.16.22.81:4220/api/Registration/UserLogin';
// Replace with your API URL

void main() {
  runApp(
    const MaterialApp(
      home: LoginScreen(),
    ),
  );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Function to perform the login API request
  Future<void> loginUser(BuildContext context) async {
    final loginId = loginIdController.text.trim();
    final password = passwordController.text.trim();

    if (loginId.isEmpty || password.isEmpty) {
      // Check if login ID or password is empty
      Fluttertoast.showToast(
        msg: "Please enter both login ID and password.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      return;
    }

    try {
      final Map<String, dynamic> loginData = {
        "LoginId": loginId,
        "Password": password,
      };

      final response = await http.post(
        Uri.parse('http://172.16.22.81:4220/api/Registration/UserLogin'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(loginData),
      );

      if (response.statusCode == 200) {
        // Successful login, handle the response data here
        final responseData = jsonDecode(response.body);
        print('Login Response: $responseData');
        final respCode = responseData['respCode'];
        final errMessage = responseData['errMessage'];

        if (respCode == '100') {
          // Login is successful
          Fluttertoast.showToast(
            msg: "Login Successful!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0,
          );
          // Navigate to the Dashboard screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        } else {
          // Handle other possible error cases if needed
          print('Login Failed: $errMessage');

          // Display a toast message for failed login
          Fluttertoast.showToast(
            msg: "Login Failed. $errMessage",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white, // Change to your preferred color
            textColor: Colors.black,
            fontSize: 16.0,
          );
        }
      } else {
        // Handle unsuccessful login here
        print('Login Failed: ${response.body}');

        // Display a toast message for failed login
        Fluttertoast.showToast(
          msg: "Login Failed. Please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white, // Change to your preferred color
          textColor: Colors.black,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      // Handle any errors that occurred during the API request
      print('Error: $e');
      // Display an error toast message if there's an issue with the request
      Fluttertoast.showToast(
        msg: "An error occurred. Please try again later.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white, // Change to your preferred color
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                'Hello\nLog In Here!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 230.0),
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
                      TextField(
                        controller: loginIdController,
                        decoration: const InputDecoration(
                          label: Text(
                            'Login ID',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ObscureText(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 70),
                      GestureDetector(
                        onTap: () {
                          // Call the loginUser function with the username and password
                          loginUser(context);
                        },
                        child: Container(
                          height: 50,
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
                          child: const Center(
                            child: Text(
                              'LOG IN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
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

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    loginIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

class ObscureText extends StatefulWidget {
  final TextEditingController controller;
  final InputDecoration decoration;

  const ObscureText({Key? key, required this.controller, required this.decoration})
      : super(key: key);

  @override
  _ObscureTextState createState() => _ObscureTextState();
}

class _ObscureTextState extends State<ObscureText> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: obscure,
      decoration: widget.decoration.copyWith(
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              obscure = !obscure;
            });
          },
          child: Icon(
            obscure ? Icons.visibility_off_outlined : Icons.visibility,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
