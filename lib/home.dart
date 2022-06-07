import 'package:flutter/material.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:newton_employee/leave.dart';
import 'package:newton_employee/leave_approval.dart';
import 'package:newton_employee/login.dart';
import 'package:newton_employee/policy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'nominee.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _calendarControllerToday = AdvancedCalendarController.today();
  final List<DateTime> events = [
    DateTime.utc(2021, 08, 10, 12),
    DateTime.utc(2021, 08, 11, 12)
  ];
  var place;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    method();
  }

  var EmpName;
  method() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      EmpName = sharedPreferences.getString('EmpName');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  child: Text(
                    EmpName != null ? 'Hi $EmpName' : 'Hi User!',
                    style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 10, 10, 10)),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  elevation: 10,
                                  child: SizedBox(
                                      height: 120,
                                      width: 300,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            "Are you sure for logout?",
                                          ),
                                          Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const Login()));
                                                    },
                                                    child: const Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              );
                            });
                      },
                      child: Image.asset(
                        'assets/images/logout.png',
                        scale: 2.3,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        showBottomSheet();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Image.asset(
                          'assets/images/menu.png',
                          scale: 2.5,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdvancedCalendar(
                controller: _calendarControllerToday,
                events: events,
                startWeekDay: 1,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'No Activity for this day',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Leave()));
            },
            child: const Text(
              'Add Leave',
              style: TextStyle(
                  color: Color.fromARGB(255, 29, 117, 189),
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Attendance',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Location',
                style: TextStyle(),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: DropdownButtonFormField<String>(
                hint: const Text('Select Location'),
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
                value: place,

                dropdownColor: Colors.white,
                isExpanded: true,

                iconSize: 20,
                style: const TextStyle(color: Colors.black),

                items: [
                  'In Office',
                  'In Field',
                  'Travelling',
                  'Training',
                  'WFH',
                  'External Meeting'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (salutation) {
                  setState(() {
                    place = salutation;
                  });
                },
                //value: dropdownProject,
                validator: (value) => value == null ? 'field required' : null,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Check-In'),
          ),
        ]),
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return Container(
          height: 200,
          width: double.infinity,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Nominee()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/nominee.png',
                              scale: 2.1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('Nominee')
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/incom.png',
                            scale: 2.1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text('Income Tax')
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/salary.png',
                            scale: 2.1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text('Salary/TDS')
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/pay.png',
                            scale: 0.5,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text('Pay Slip')
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Policy()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/policy.png',
                              scale: 1.8,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('Policies')
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LeaveApproval()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/leave.png',
                              scale: 0.7,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('Leave Approval')
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
