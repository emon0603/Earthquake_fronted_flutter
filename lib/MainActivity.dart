
import 'package:earthquake/FragmentClass/EarthquakePage.dart';
import 'package:earthquake/FragmentClass/EmergencyPage.dart';
import 'package:earthquake/FragmentClass/HomePage.dart';
import 'package:earthquake/FragmentClass/MorePage.dart';
import 'package:earthquake/FragmentClass/WeatherPage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

class CustomBottomNavDemo extends StatefulWidget {
  @override
  _CustomBottomNavDemoState createState() => _CustomBottomNavDemoState();
}

class _CustomBottomNavDemoState extends State<CustomBottomNavDemo> {
  int _currentIndex = 0;
  final List<Widget> _pages = [

    WeatherPage(),
    EmergencyPage(),
    HomePage(),
    EarthquakePage(),
    MorePage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: _pages[_currentIndex],

      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() => _currentIndex = i);
        },
      ),
    );
  }
}

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, -4),
          ),
        ],
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Stack(
        children: [
          // Middle icon
          // Middle icon
          Center(
            child: Transform.translate(
              offset: Offset(0, -28),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      onTap(2); // index 2 for center icon
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      padding: EdgeInsetsGeometry.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/ic_earth.svg",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  if (currentIndex == 2)
                    Container(
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          ),



          // Side icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(
                icon: Icons.cloud_outlined,
                label: "weather",
                index: 0,
              ),
              _navItem(
                icon: Icons.sos_outlined,
                label: "Emergency",
                index: 1,
              ),
              SizedBox(width: 60), // gap for center icon
              _navItem(
                icon: Icons.public_outlined,
                label: "earthquake",
                index: 3,
              ),
              _navItem(
                icon: Icons.grid_view,
                label: "more",
                index: 4,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navItem({required IconData icon, required String label, required int index}) {
    bool active = (index == currentIndex);

    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 26, color: active ? Colors.blue : Colors.black54),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: active ? Colors.blue : Colors.black54,
            ),
          ),
          if (active)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Container(
                height: 5,
                width: 5,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}