import 'package:flutter/material.dart';
import 'package:restaurant_client/views/home_page_content.dart';
import 'package:restaurant_client/views/login_page.dart';
import 'home_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';




class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens(){
      return [
        HomePageContent(),
        LoginPage(),
      ];
    };

    _navBarsItems(){
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.bus_alert),
          title: ("Voyages"),
          activeColorPrimary: Color.fromARGB(255,255, 92, 0),
          inactiveColorPrimary: Colors.white
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.list),
          title: ("Reservations"),
          activeColorPrimary: Color.fromARGB(255,255, 92, 0),
          inactiveColorPrimary: Colors.white
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
      backgroundColor: Color.fromARGB(255, 5, 25, 76),
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