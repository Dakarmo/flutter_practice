import 'package:medical_heathcare/models/product.dart';
import 'package:medical_heathcare/services/api_service.dart';
import 'package:medical_heathcare/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductRepository {
  final APIService _apiService = APIService();

  Future<Map<String, dynamic>> getProductList(int page, String? searchValue, SortTypes? sortType) async{
    Map<String, String> params = {
      "page" : page.toString(),
      "limit" : PAGE_LIMIT.toString(),
    };
    if(searchValue != null){
      params["productName"]=searchValue;
    }
    if(sortType != null) {
      params["sortType"] = sortType.toString().split('.').last;
    }

    http.Response response = await _apiService.get("/products", params);
    dynamic responseJson = jsonDecode(response.body);
    final productsData = responseJson['data']['content'] as List;

    List<Product> productsList = productsData.map((json) => Product.fromJson(json)).toList();

    final pagesData = responseJson['data']['totalPages'];
    Map<String, dynamic> returnedData = {
      "products list": productsList,
      "pages number": pagesData,
    };

    return returnedData;


  }

  Future<Product> addProduct(Product product) async{
    http.Response response = await _apiService.post("/products/add", product.toJson(product));

    dynamic responseJson = jsonDecode(response.body);
    print(responseJson);
    final jsonData=responseJson["data"];
    print(jsonData);
    Product savedProduct = Product.fromJson(jsonData);
    return savedProduct;



  }

  Future<Product> editProduct(Product product) async{
    http.Response response = await _apiService.put("/products/edit", product.toJson(product));

    dynamic responseJson = jsonDecode(response.body);
    final jsonData=responseJson["data"];
    Product editProduct = Product.fromJson(jsonData);
    return editProduct;


  }

  Future<dynamic> deleteProduct(Product product) async{
    http.Response response = await _apiService.delete("/products/delete/${product.id}");

    dynamic responseJson = jsonDecode(response.body);
    final jsonMessage = responseJson["message"];


  }

}