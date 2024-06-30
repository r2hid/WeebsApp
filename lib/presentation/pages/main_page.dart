import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wibu_app/presentation/pages/top_anime_page.dart';
import 'package:wibu_app/presentation/pages/explore_page.dart';
import 'package:wibu_app/presentation/pages/random_anime_page.dart';
import 'package:wibu_app/presentation/pages/user_page.dart';
import 'package:wibu_app/presentation/viewmodels/user_viewmodel.dart';
import 'package:wibu_app/presentation/pages/login_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions(UserViewModel userViewModel) => [
    TopAnimePage(),
    ExplorePage(),
    RandomAnimePage(),
    if (userViewModel.isAdmin) UsersPage(),
  ];

  List<BottomNavigationBarItem> _navigationItems(UserViewModel userViewModel) => [
    BottomNavigationBarItem(
      icon: Icon(Icons.star),
      label: 'Top Anime',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Explore',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shuffle),
      label: 'Random',
    ),
    if (userViewModel.isAdmin)
      BottomNavigationBarItem(
        icon: Icon(Icons.supervisor_account),
        label: 'Users',
      ),
  ];

  void _onItemTapped(int index, UserViewModel userViewModel) {
    setState(() {
      final maxIndex = _widgetOptions(userViewModel).length - 1;
      _selectedIndex = (index <= maxIndex) ? index : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    if (_selectedIndex >= _widgetOptions(userViewModel).length) {
      _selectedIndex = 0;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Weebs App'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              userViewModel.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _widgetOptions(userViewModel)[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationItems(userViewModel),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) => _onItemTapped(index, userViewModel),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}