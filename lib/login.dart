// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:newton_employee/change_password.dart';
import 'package:newton_employee/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'APIs/api.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _empIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> login(user, password) async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // var body = jsonEncode(<String, String>{
        //   "phone_number": phoneNumber,
        // });
        var response = await http.get(
          Uri.parse(
              "${APIUrls.BASE_URL}/GetUserlogindetails/$user/$password/TC0000036"),
        );
        try {
          var convertJson = jsonDecode(response.body);

          if (convertJson[0] != null) {
            await sharedPreferences.setString(
                "EmpId", convertJson[0]["USER_CODE"]);
            await sharedPreferences.setString(
                "EmpName", convertJson[0]["EMPLOYEENAME"]);
            await sharedPreferences.setString(
                "TCode", convertJson[0]["T_CODE"]);
            await sharedPreferences.setString(
                "EmpCategoryCode", convertJson[0]["EMPL_CTGRY_CODE"]);
            Fluttertoast.showToast(
                msg: 'Successfully LoggedIn', gravity: ToastGravity.BOTTOM);
            Navigator.of(context).pushReplacement(
                // ignore: prefer_const_constructors
                MaterialPageRoute(builder: (context) => Dashboard()));

            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
                msg: convertJson['error_msg'], gravity: ToastGravity.BOTTOM);
          }
        } catch (e) {
          // ignore: avoid_print
          print(e.toString());
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg: "Something went wrong, try again later",
              gravity: ToastGravity.BOTTOM);
        }
      }
    } on SocketException catch (_) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "No internet connection. Connect to the internet and try again.",
          gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/images/logo.jpg',
              scale: 1.6,
            ),
            const Text(
              'Employee Management',
              style: TextStyle(
                  color: Color.fromARGB(255, 60, 79, 112),
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.7,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: _empIdController,
                              decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(15.0),
                                  labelText: 'Employee Id',
                                  border: OutlineInputBorder()),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'The field is mandatory';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(15.0),
                                  labelText: 'Password',
                                  border: OutlineInputBorder()),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'The field is mandatory';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChnagePassword()));
                              },
                              child: const Align(
                                alignment: Alignment.topRight,
                                child: Text('Forgot Password?',
                                    style: TextStyle(color: Colors.blue)),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  login(_empIdController.text,
                                      _passwordController.text);
                                }
                              },
                              child: Container(
                                child: Center(
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 23,
                                          height: 23,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ))
                                      : const Text(
                                          'Log in',
                                          textScaleFactor: 1.4,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(255, 16, 36, 53),
                                ),
                                height: 43,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
            // Align(
            //   alignment: FractionalOffset.bottomCenter,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 20),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: const [
            //         Text('English'),
            //         Text('Terms'),
            //         Text('Private'),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
