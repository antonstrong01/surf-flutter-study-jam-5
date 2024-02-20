import 'package:flutter/material.dart';
import 'package:meme_generator/screen/meme_generator_screen.dart';
import 'package:meme_generator/screen/templates_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const MemeGeneratorScreen(),
    const TempatesScreen(),
    PlaceholderWidget(Colors.blue),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Meme',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Templates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_label),
            label: 'New template',
          )
        ],
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
