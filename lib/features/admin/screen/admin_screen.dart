import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages=[
    const Center(child: Text("Posts Page"),),
    const Center(child: Text("Analytics Page"),),
    const Center(child: Text("Cart Page"),),
  ];
  void updatePage(int page){
    setState(() {
      _page=page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container( 
            decoration: const BoxDecoration(
                gradient: AppGlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "assets/images/amazon_in.png",
                  width: 120,
                  height: 45,
                ),
              ),
              Text("Admin",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: AppGlobalVariables.selectedNavBarColor,
        unselectedItemColor: AppGlobalVariables.unselectedNavBarColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // home page
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _page == 0
                            ? AppGlobalVariables.selectedNavBarColor
                            : AppGlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth),
                  ),
                ),
                child: Icon(Icons.home_outlined),
              ),
              label: ""),
          //analytics
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _page == 1
                            ? AppGlobalVariables.selectedNavBarColor
                            : AppGlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth),
                  ),
                ),
                child: Icon(Icons.person_outline_outlined),
              ),
              label: ""),

          //orders
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _page == 1
                            ? AppGlobalVariables.selectedNavBarColor
                            : AppGlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth),
                  ),
                ),
                child: Icon(Icons.all_inbox_outlined),
              ),
              label: ""),

        ],
      ),
      body: pages[_page],
    );
  }
}
