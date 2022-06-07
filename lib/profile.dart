import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newton_employee/login.dart';

import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'APIs/api.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final _fnameController = TextEditingController();
  final _mnameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _dobController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _branchNameController = TextEditingController();
  final _banckACNOController = TextEditingController();
  final _ifscCodeController = TextEditingController();
  final _uanController = TextEditingController();
  final _esiIdController = TextEditingController();
  final _gratuityIdController = TextEditingController();

  var gender;
  bool isLoading = false;

  var outputDate;
  var apiData;
  Future<void> getprofile() async {
    setState(() {
      isLoading = true;
    });
    //var provider = Provider.of<DashboardProvider>(context, listen: false);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var response = await http.get(
            Uri.parse(
              "${APIUrls.BASE_URL}/GetEmployeeprofile/${sharedPreferences.getString("EmpId")}",
            ),
            headers: {
              'Content-Type': 'application/json;charset=UTF-8',
              "Accept": "applicarion/json",
              'Charset': 'utf-8',
            });

        if (response.statusCode == 401) {
          Fluttertoast.showToast(
              msg: 'sessionTimeOut', gravity: ToastGravity.BOTTOM);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Login()),
              (route) => false);
          setState(() {
            isLoading = false;
          });
        } else {
          var convertJson = jsonDecode(response.body);
          try {
            if (convertJson != null) {
              apiData = convertJson;

              var inputFormat = DateFormat('yyyy-MM-dd');
              var inputDate = inputFormat.parse('${apiData['DATE_OF_BIRTH']}');
              var outputFormat = DateFormat('dd/MM/yyyy');

              outputDate = outputFormat.format(inputDate);

              setState(() {
                isLoading = false;
              });
              //provider.setIsLoading(false);
            } else {
              setState(() {
                isLoading = false;
              });
              //provider.setIsLoading(false);
              //Fluttertoast.showToast(msg: convertJson['error_msg'], gravity: ToastGravity.BOTTOM);
            }
          } catch (e) {
            setState(() {
              isLoading = false;
            });
            // print(e.toString());
            //provider.setIsLoading(false);
            Fluttertoast.showToast(
                msg: "Something went wrong, try again later",
                gravity: ToastGravity.BOTTOM);
          }
        }
      }
    } on SocketException catch (_) {
      setState(() {
        isLoading = false;
      });
      //provider.setIsLoading(false);
      Fluttertoast.showToast(
          msg: "No internet connection. Connect to the internet and try again.",
          gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Color.fromARGB(255, 20, 20, 20),
          size: 18,
        ),
        title: const Text(
          'Profile',
          style:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RichText(
                text: const TextSpan(
                    text: 'First Name',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ))
                    ]),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _fnameController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    isDense: true,
                    contentPadding: EdgeInsets.all(10.0),
                    hintStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'The field is mandatory';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 7,
              ),
              RichText(
                text: const TextSpan(
                    text: 'Middel Name',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ))
                    ]),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _mnameController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    isDense: true,
                    contentPadding: EdgeInsets.all(10.0),
                    hintStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'The field is mandatory';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 7,
              ),
              RichText(
                text: const TextSpan(
                    text: 'Last Name',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ))
                    ]),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _lNameController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    isDense: true,
                    contentPadding: EdgeInsets.all(10.0),
                    hintStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'The field is mandatory';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 7,
              ),
              RichText(
                text: const TextSpan(
                    text: 'Address',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ))
                    ]),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _addressController,
                maxLines: 3,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    isDense: true,
                    contentPadding: EdgeInsets.all(10.0),
                    hintStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'The field is mandatory';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 7,
              ),
              RichText(
                text: const TextSpan(
                    text: 'Gender',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ))
                    ]),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    isDense: true, // Added this
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  value: gender,

                  dropdownColor: Colors.white,
                  isExpanded: true,

                  iconSize: 20,
                  style: const TextStyle(color: Colors.black),

                  items: ['Male', 'Female', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (salutation) {
                    setState(() {
                      gender = salutation;
                    });
                  },
                  //value: dropdownProject,
                  validator: (value) => value == null ? 'field required' : null,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const Text(
                'DOB',
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _dobController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    isDense: true,
                    contentPadding: EdgeInsets.all(10.0),
                    hintStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'The field is mandatory';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 7,
              ),
              RichText(
                text: const TextSpan(
                    text: 'Bank Name',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ))
                    ]),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _bankNameController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    isDense: true,
                    contentPadding: EdgeInsets.all(10.0),
                    hintStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'The field is mandatory';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 7,
              ),
              const Text(
                'Branch Name',
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _branchNameController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    isDense: true,
                    contentPadding: EdgeInsets.all(10.0),
                    hintStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'The field is mandatory';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 7,
              ),
              RichText(
                text: const TextSpan(
                    text: 'Bank A/c Number',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ))
                    ]),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _banckACNOController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    isDense: true,
                    contentPadding: EdgeInsets.all(10.0),
                    hintStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'The field is mandatory';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 7,
              ),
              RichText(
                text: const TextSpan(
                    text: 'IFSC Code',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ))
                    ]),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _ifscCodeController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    isDense: true,
                    contentPadding: EdgeInsets.all(10.0),
                    hintStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'The field is mandatory';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 7,
              ),
              const Text(
                'UAN',
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _uanController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    isDense: true,
                    contentPadding: EdgeInsets.all(10.0),
                    hintStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'The field is mandatory';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 7,
              ),
              const Text(
                'ESI ID',
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _esiIdController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    isDense: true,
                    contentPadding: EdgeInsets.all(10.0),
                    hintStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'The field is mandatory';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 7,
              ),
              const Text(
                'Gratuity ID',
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _gratuityIdController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    isDense: true,
                    contentPadding: EdgeInsets.all(10.0),
                    hintStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )),
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
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // updateProfile(
                    //     _fnameController.text,
                    //     _lNameController.text,
                    //     _addressController.text,
                    //     _dobController.text,
                    //     gender,
                    //     _bankNameController.text,
                    //     _branchNameController.text,
                    //     _banckACNOController.text,
                    //     _ifscCodeController.text,
                    //     _uanController.text,
                    //     _esiIdController.text,
                    //     _gratuityIdController.text);
                  }
                },
                child: Container(
                  child: const Center(
                    child: Text(
                      'Update Profile ',
                      textScaleFactor: 1.4,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 16, 36, 53),
                  ),
                  height: 45,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
