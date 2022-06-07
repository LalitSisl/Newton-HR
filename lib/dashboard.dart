import 'package:flutter/material.dart';
import 'package:newton_employee/appointment.dart';
import 'package:newton_employee/attendance.dart';
import 'package:newton_employee/home.dart';
import 'package:newton_employee/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  bool _show = false;
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Appointment(),
    Attendance(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
            // backgroundColor: Colors.transparent,
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Color.fromARGB(255, 148, 68, 62),
                  size: 25,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/appointment.png',
                  scale: 2.2,
                  color: const Color.fromARGB(255, 148, 68, 62),
                ),
                label: 'Appointment',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/aatendance.png',
                  scale: 1.9,
                  color: const Color.fromARGB(255, 148, 68, 62),
                ),
                label: 'Attendance',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 145, 28, 20),
                ),
                label: 'Profile',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            // selectedItemColor: Colors.black,
            // unselectedItemColor: Colors.black,
            iconSize: 25,
            onTap: _onItemTapped,
            elevation: 0),
      ),
    );
  }
}
