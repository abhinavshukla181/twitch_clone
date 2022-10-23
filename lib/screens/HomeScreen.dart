import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_clone/providers/user_provider.dart';
import 'package:twitch_clone/screens/feed_screen.dart';
import 'package:twitch_clone/screens/go_live_screen.dart';
import 'package:twitch_clone/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  List<Widget> pages = [
    const FeedScreen(),
    const GoLiveScreen(),
    const Center(
      child: Text('Browser'),
    ),
  ];

  //here this pages is a list of widgets

  onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: buttonColor,
          unselectedItemColor: primaryColor,
          backgroundColor: backgroundColor,
          unselectedFontSize: 12,
          onTap: onPageChange,
          currentIndex: _page,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'Following',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_rounded,
              ),
              label: 'Go live',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.copy,
              ),
              label: 'Browser',
            ),
          ]),
      body: pages[_page],
    );
  }
}
