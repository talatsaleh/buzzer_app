import 'package:buzzer_app/core/widgets/customButtonNavigator.dart';
import 'package:buzzer_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:buzzer_app/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:buzzer_app/features/restaurant/presentation/screens/restaurant_list_screen.dart';
import 'package:flutter/material.dart';

class CustomNavigationScreen extends StatefulWidget {
  @override
  _CustomNavigationScreenState createState() => _CustomNavigationScreenState();
}

class _CustomNavigationScreenState extends State<CustomNavigationScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        // Disable swiping; use buttons instead
        children: [
          RestaurantsScreen(),
          NotificationsScreen(),
          Center(child: Text("Profile Screen", style: TextStyle(fontSize: 24))),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomButtonNavigator(
          indexSelected: _currentIndex, onTap: _onTabTapped),
    );
  }
}
