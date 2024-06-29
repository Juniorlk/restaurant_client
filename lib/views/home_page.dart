import 'package:flutter/material.dart';
import 'package:foodapp/views/commande_page_content.dart';
import 'package:foodapp/views/constants.dart';
import 'package:foodapp/views/home_page_content.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:foodapp/views/profile_page_content.dart';
import 'package:foodapp/views/reservation_page_content.dart';




class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens(){
      return [
        HomePageContent(),
        CommandePage(),
        ReservationPage(),
        ProfilePage(),
      ];
    };

    _navBarsItems(){
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home_rounded),
          title: ("Home"),
          activeColorPrimary: Color(primaryColor),
          inactiveColorPrimary: Colors.grey
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.restaurant_menu),
          title: ("Commandes"),
          activeColorPrimary: Color(primaryColor),
          inactiveColorPrimary: Colors.grey.shade600
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.table_bar_rounded),
          title: ("Reservation"),
          activeColorPrimary: Color(primaryColor),
          inactiveColorPrimary: Colors.grey.shade600
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.person_rounded),
          title: ("Profile"),
          activeColorPrimary: Color(primaryColor),
          inactiveColorPrimary: Colors.grey.shade600
        ),
        // PersistentBottomNavBarItem(
        //   icon: Icon(Icons.home),
        //   title: ("Home"),
        //   activeColorPrimary: Color.fromARGB(255,255, 92, 0),
        //   inactiveColorPrimary: Colors.white
        // ),
        // PersistentBottomNavBarItem(
        //   icon: Icon(Icons.notifications),
        //   title: ("Notifications"),
        //   activeColorPrimary: Color.fromARGB(255,255, 92, 0),
        //   inactiveColorPrimary: Colors.white
        // ),
        // PersistentBottomNavBarItem(
        //   icon: Icon(Icons.person_pin_circle_rounded),
        //   title: ("Profil"),
        //   activeColorPrimary: Color.fromARGB(255,255, 92, 0),
        //   inactiveColorPrimary: Colors.white
        // ),
      ];
    }
    return PersistentTabView(
      context, 
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.grey.shade100,
      handleAndroidBackButtonPress: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        // borderRadius: BorderRadius.circular(10),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }

}