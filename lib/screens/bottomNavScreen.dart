import 'package:flutter/material.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedTab = 0;
  static const List<Widget> _pageTabs = <Widget>[
    Text(
      'Home Screen',
    ),
    Text(
      'Messages Screen',
    ),
    Text(
      'Profile Screen',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Nav Bar'),
      ),
      body: Center(
        child: _pageTabs.elementAt(_selectedTab),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedTab,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
    ;
  }
}
