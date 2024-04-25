import 'package:flutter/material.dart';

class TopNavigationPage extends StatefulWidget {
  const TopNavigationPage({Key? key}) : super(key: key);

  @override
  State<TopNavigationPage> createState() => _TopNavigationPageState();
}

class _TopNavigationPageState extends State<TopNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "LEFT",
              ),
              Tab(
                text: "MIDDLE",
              ),
              Tab(
                text: "RIGHT",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text("This is the left tab")),
            Center(child: Text("This is the middle tab")),
            Center(child: Text("This is the right tab")),
          ],
        ),
      ),
    );
  }
}
