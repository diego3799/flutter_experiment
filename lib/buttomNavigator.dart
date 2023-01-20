import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class ButtomNavigator extends StatefulWidget {
  final Widget child;
  const ButtomNavigator({super.key, required this.child});

  @override
  State<ButtomNavigator> createState() => _ButtomNavigatorState();
}

class _ButtomNavigatorState extends State<ButtomNavigator> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Appbar")),
      body: widget.child,
      backgroundColor: Colors.grey[200],
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        items: const [
          Icon(
            Icons.add,
            size: 30,
            color: Colors.amber,
          ),
          Icon(
            Icons.list,
            size: 30,
            color: Colors.amber,
          ),
          Icon(
            Icons.compare_arrows,
            size: 30,
            color: Colors.amber,
          ),
          Icon(
            Icons.api,
            size: 30,
            color: Colors.amber,
          ),
        ],
        index: activeIndex,
        onTap: (index) {
          setState(() {
            activeIndex = index;
          });
        },
      ),
    );
  }
}
