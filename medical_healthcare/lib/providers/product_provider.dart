import 'package:flutter/cupertino.dart';
import 'package:medical_heathcare/Reposirories/product_repository.dart';
import 'package:medical_heathcare/models/product.dart';
import 'package:medical_heathcare/utils/utils.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];
  Product? productToEdit;
  int pagesNumber = 0;

  final ProductRepository _productRepository = ProductRepository();

  getProducts(int page, String? searchValue, SortTypes? sortType, GetTypes getType) async{
    Map<String, dynamic> returnedData = await _productRepository.getProductList(page, searchValue, sortType);

    List<Product> pageProducts = returnedData["product list"];
    pagesNumber = returnedData["pages number"];
    if(getType == GetTypes.PAGING){
      products = products+pageProducts;
    }else if(getType == GetTypes.FILTER){
      products = pageProducts;
    }

    notifyListeners();
  }

  addProduct(Product product) async {
    Product saveProduct = await _productRepository.addProduct(product);
    products.add(saveProduct);
    notifyListeners();
  }

  editProduct(Product product) async {
    Product editedProduct = await _productRepository.editProduct(product);
    products[products.indexOf(product)] = editedProduct;
    notifyListeners();
  }

  deleteProduct(Product product) async {
    await _productRepository.deleteProduct(product);

    products.remove(product);
    notifyListeners();
  }

}