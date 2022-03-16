import 'package:flutter/material.dart';
import 'package:vuemax_tv/screens/navScreen/homeScreen.dart';
import 'package:vuemax_tv/screens/navScreen/tvScreen.dart';
import 'package:vuemax_tv/screens/navScreen/searchScreen.dart';
import 'package:vuemax_tv/screens/navScreen/profileScreen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  PageController pageController = PageController();


  void onTapSelect(int index){
    setState((){
      _selectedIndex = index;
    });

    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: const <Widget>[
          HomeScreen(),
          TvScreen(),
          SearchScreen(),
          ProfileScreen()
        ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "", backgroundColor: Colors.black  ),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: "",  backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "",  backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "",  backgroundColor: Colors.black)
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade600,
        onTap: onTapSelect,
        elevation: 15,
        enableFeedback: true,
        backgroundColor: Colors.black,
      ),
    );
  }
}