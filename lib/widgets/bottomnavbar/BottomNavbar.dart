// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:gabriels_vault/screens/constant/ColorsPalette.dart';

class BottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  BottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        BottomAppBar(
          color: const Color.fromARGB(255, 167, 160, 160),
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildNavItem(0, Icons.message_rounded, 'Messages'),
                _buildNavItem(1, Icons.image_outlined, 'Media'),
                SizedBox(width: 40),
                _buildNavItem(2, Icons.people_alt_outlined, 'Recipients'),
                _buildNavItem(3, Icons.person_3_outlined, 'Account'),
              ],
            ),
          ),
        ),
        Positioned(
          top: -50,
          child: ClipPath(
            clipper: HalfCircleClipper(),
            child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 182, 177, 177),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(200, 200),
                    topRight: Radius.circular(200),
                    
                  ),
                )),
          ),
        ),
        Positioned(
          top: -28,
          child: FloatingActionButton(
            elevation: 4,
            shape: CircleBorder(),
            backgroundColor: ColorsPalette.primary,
            child: Icon(Icons.add, size: 30, color: Colors.white),
            onPressed: () {
            
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => onItemTapped(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: isSelected ? ColorsPalette.primary : Colors.black,
              size: 20,
            ),
            Text(
              label,
              style: TextStyle(
                  color: isSelected ? ColorsPalette.primary : Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
