import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../models/product.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic("deuzwzvf9", "wxjb7jo9");
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price);
      http.Response response = await http.post(
          Uri.parse('$uri/admin/add-product'),
          body: product.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.user.token
          });
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackbar(context, "Product Added Successfully!");
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<List<Product>?> getProducts({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http
          .get(Uri.parse('$uri/admin/get-products'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': user.user.token
      });
      List<Product> dataList = [];
      // httpErrorHandle(
      //     response: response,
      //     context: context,
      //     onSuccess: () {
      //       showSnackbar(context, "Product Added Successfully!");
      //       Navigator.pop(context);
      //     });
      for (var json in jsonDecode(response.body)["data"]) {
        Product data = Product.fromJson(json);
        dataList.add(data);
      }
      return dataList;
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
