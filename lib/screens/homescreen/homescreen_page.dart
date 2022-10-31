import 'package:decisionroll/screens/homescreen/homepage.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreenPage extends ConsumerStatefulWidget {
  const HomeScreenPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends ConsumerState<HomeScreenPage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const Center(child: Text('Your Decisions')),
    const Center(child: Text('Profile')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackgroundColor,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          elevation: 0.0,
          showUnselectedLabels: false,
          selectedFontSize: 12,
          selectedLabelStyle: const TextStyle(
            color: blueColor,
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: whiteBackgroundColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.diceFour,
                color: blueColor,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.dice,
                color: blueColor,
              ),
              label: 'Your Decisions',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.user,
                color: blueColor,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
