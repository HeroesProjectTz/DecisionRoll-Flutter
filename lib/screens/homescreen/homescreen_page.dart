import 'package:decisionroll/main.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackgroundColor,
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: onTap,
        items: const [
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
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = goRouter.location;
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/decisions')) {
      return 1;
    }
    if (location.startsWith('/profile')) {
      return 2;
    }
    return 0;
  }

  void onTap(int value) {
    switch (value) {
      case 0:
        return context.go('/home');
      case 1:
        return context.go('/decisions');
      case 2:
        return context.go('/profile');
      default:
        return context.go('/home');
    }
  }
}
// }
// class HomeScreenPage extends ConsumerStatefulWidget {
//   const HomeScreenPage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenPageState();
// }



// class _HomeScreenPageState extends ConsumerState<HomeScreenPage> {
//   int _selectedIndex = 0;

//   static final List<Widget> _widgetOptions = <Widget>[
//     const HomePage(),
//     const Center(child: Text('Your Decisions')),
//     const Center(child: Text('Profile')),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: whiteBackgroundColor,
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: SafeArea(
//         child: BottomNavigationBar(
          // elevation: 0.0,
          // showUnselectedLabels: false,
          // selectedFontSize: 12,
          // selectedLabelStyle: const TextStyle(
          //   color: blueColor,
          //   fontWeight: FontWeight.w500,
          // ),
          // backgroundColor: whiteBackgroundColor,
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
              // icon: Icon(
              //   FontAwesomeIcons.diceFour,
              //   color: blueColor,
              // ),
              // label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 FontAwesomeIcons.dice,
//                 color: blueColor,
//               ),
//               label: 'Your Decisions',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 FontAwesomeIcons.user,
//                 color: blueColor,
//               ),
//               label: 'Profile',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           onTap: _onItemTapped,
//         ),
//       ),
//     );
//   }
// }
