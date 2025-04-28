import 'package:flutter/material.dart';

class CustomButtonNavigator extends StatefulWidget {
  const CustomButtonNavigator(
      {super.key, required this.indexSelected, required this.onTap});

  final int indexSelected;
  final Function(int index) onTap;

  @override
  State<CustomButtonNavigator> createState() => CustomButtonNavigatorState();
}

class CustomButtonNavigatorState extends State<CustomButtonNavigator> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          // Home Button
          _CustomNavButton(
            onTap: widget.onTap,
            title: 'Home',
            currentIndex: widget.indexSelected,
            fixedIndex: 0,
            iconData: Icons.home,
          ),
          _CustomNavButton(
              onTap: widget.onTap,
              title: 'Notifications',
              currentIndex: widget.indexSelected,
              fixedIndex: 1,
              iconData: Icons.notifications),
          _CustomNavButton(
              onTap: widget.onTap,
              title: 'Profile',
              currentIndex: widget.indexSelected,
              fixedIndex: 2,
              iconData: Icons.person)
        ]));
  }
}

class _CustomNavButton extends StatelessWidget {
  const _CustomNavButton(
      {required this.currentIndex,
      required this.fixedIndex,
      required this.iconData,
      required this.onTap,
      required this.title});

  final int currentIndex;
  final int fixedIndex;
  final IconData iconData;
  final String title;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(fixedIndex),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.bounceIn,
        decoration: fixedIndex == currentIndex
            ? BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        padding: fixedIndex == currentIndex
            ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
            : const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Row(
          children: [
            Icon(iconData,
                color:
                    fixedIndex == currentIndex ? Colors.yellow : Colors.grey),
            if (currentIndex == fixedIndex) ...[
              const SizedBox(width: 5),
              Text(
                title,
                style: const TextStyle(color: Colors.yellow),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
