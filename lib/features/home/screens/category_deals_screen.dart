import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/service/home_service.dart';
import 'package:flutter/material.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = "/category-deals";
  CategoryDealsScreen({super.key, required this.category});
  String category;
  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    HomeService().getCategoryProduct(context, widget.category);
    super.initState();
  }
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(
              'Keep Shopping for ${widget.category} ',
              style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
            ),
          ),
          SizedBox(
            height: 170,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 15),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.4,
                    mainAxisSpacing: 10),
                itemCount: 10,
                itemBuilder: (context,index ){
                  return Text('hello');
                }),
          )
        ],
      ),
    );
  }
}
