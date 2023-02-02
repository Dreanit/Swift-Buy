import 'package:amazon_clone/features/search/service/search_service.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search-screen";
  final String searchQuery;
  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchService _searchService=SearchService();
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  bool isLoading=false;
    List<Product> productList=[];
  getData()async{
    setState(() {
      isLoading=true;
    });
    productList=await _searchService.getSearchedProduct(context, widget.searchQuery);
    print(productList.length);
    setState(() {
      isLoading=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.searchQuery),
      ),
    );
  }
}
