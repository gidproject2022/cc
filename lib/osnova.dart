import 'package:flutter/material.dart';
import 'package:stick/constains/colors.dart';
import 'package:stick/screens/add_screen.dart';
import 'package:stick/screens/home_screen.dart';
import 'package:stick/screens/profile_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Osnova extends StatefulWidget {
  const Osnova({Key? key}) : super(key: key);

  @override
  State<Osnova> createState() => _OsnovaState();
}

class _OsnovaState extends State<Osnova> {
  int currentIndex = 0;
  final screens = [
    const HomeScreen(),
    const AddScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Container(
            child: screens[currentIndex],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 40,
          onTap: (index) => setState(() {
            currentIndex = index;
          }),
          items: [
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/icons/home.svg',
                color: activeItemColor,
              ),
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                color: unactiveItemColor,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/icons/add.svg',
                color: activeItemColor,
              ),
              icon: SvgPicture.asset(
                'assets/icons/add.svg',
                color: unactiveItemColor,
              ),
              label: "Add",
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/icons/profile.svg',
                color: activeItemColor,
              ),
              icon: SvgPicture.asset(
                'assets/icons/profile.svg',
                color: unactiveItemColor,
              ),
              label: "Profile",
            ),
          ],
        ),
      );
}
