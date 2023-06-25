import 'package:flutter/material.dart';
import 'package:que_dijo_app/views/sections/summary_body_view.dart';
import 'package:que_dijo_app/views/sections/summary_public_body_view.dart';
import 'package:que_dijo_app/views/sections/user_profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  final List<Widget> _children = [
    const BuildSummaryView(),
    const BuildPublicSummaryView(),
    const Text('Settings View'),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final List<String> titleAppBar = ['Home', 'Public', 'Settings', 'Profile'];

    return Scaffold(
      appBar: AppBar(
        title: Text(titleAppBar[currentIndex]),
        centerTitle: false,
      ),
      body: _children[currentIndex],
      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/upload');
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Public',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.secondary,
      ),
    );
  }
}
