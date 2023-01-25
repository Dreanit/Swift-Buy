import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CategoryDealsScreen extends StatefulWidget {
  CategoryDealsScreen({super.key, required this.category});
  String category;
  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                BoxDecoration(gradient: AppGlobalVariables.appBarGradient),
          ),
          title: Text(
            widget.category,
            style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
          ),
        ),
      ),
    );
  }
}
