import 'package:flutter/material.dart';
import 'package:medical_heathcare/providers/product_provider.dart';
import 'package:medical_heathcare/utils/utils.dart';
import 'package:medical_heathcare/widgets/add_product.dart';
import 'package:medical_heathcare/widgets/elev_button.dart';
import 'package:medical_heathcare/widgets/product_container.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';


class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  List<String> sortBy = ['Price Asc', 'Price Desc', 'none'];
  SortTypes? sortTypes;
  String? sortValue;
  String? searchValue;
  int pagesNum = 0;
  int nextPages = 1;

  @override
  void initState() {

    super.initState();
    Future.delayed(Duration.zero,()async{
      await Provider.of<ProductProvider>(context,listen: false).
      getProducts(0, null, null, GetTypes.PAGING);

      pagesNum = Provider.of<ProductProvider>(context, listen: false).pagesNumber;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: APP_COLOR,
        title: const Text(
            'Liste des Produits',
            style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [SizedBox()],
      ),
      endDrawer: const AddProductDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Products',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                ElevButton(
                    text: 'Add Product',
                    icon: Icons.add,
                    onPressed: (){
                      Provider.of<ProductProvider>(context, listen: false).productToEdit = null;
                      _scaffoldkey.currentState!.openEndDrawer();
                    }
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                 SizedBox(width: 150,
                    child: TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        hintText: 'Search by name...',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (input){
                        searchValue=input;
                      },
                    ),
                 ),
                SizedBox(width: 10,),
                SizedBox(
                  width: 150,
                  child: DropdownButton(
                    hint: Text('Sort by'),
                    value: sortValue,
                    items: sortBy.map((String value) {
                      return DropdownMenuItem<String>(
                          value:value,
                          child: Text(value)
                      );
                    }).toList(),
                    onChanged: (value) {
                      sortValue = value as String;
                          if(value==sortBy[0]){
                            sortTypes=SortTypes.ASC;
                          }else if(value==sortBy[1]){
                            sortTypes=SortTypes.DESC;
                          }else {
                            sortTypes = null;
                          }

                          setState(() {

                          });
                    },
                  ),
                ),

                ElevButton(
                    text: 'Filter',
                    icon: Icons.filter_alt,
                    color: Colors.black,
                    onPressed: (){
                      Provider.of<ProductProvider>(context, listen: false).getProducts(0, searchValue, sortTypes, GetTypes.FILTER);
                      pagesNum = Provider.of<ProductProvider>(context, listen: false).pagesNumber;
                      nextPages=1;
                      setState(() {

                      });
                    }
                ),

              ],
            ),
          ),
          const SizedBox(height: 30,),
          Expanded(
            child: ResponsiveGridList(
              desiredItemWidth: 200,
              minSpacing: 20,
              children: Provider.of<ProductProvider>(context).products.map<Widget>((product) {
                return GestureDetector(
                  onTap: (){
                    Provider.of<ProductProvider>(context, listen: false).productToEdit=product;
                    _scaffoldkey.currentState!.openEndDrawer();
                  },
                  child: ProductContainer(product: product),

                );
              }).toList()
              ..add(
                pagesNum > 1?
                SizedBox(
                height: 210,
                  child: ElevButton(
                      text: 'Load More',
                      icon: Icons.add,
                      color: Colors.grey,
                      onPressed: (){
                        Provider.of<ProductProvider>(context, listen: false)
                            .getProducts(nextPages, searchValue, sortTypes, GetTypes.PAGING);
                        pagesNum--;
                        nextPages++;
                      }
                  ),
              
            ):const SizedBox()
            ),
            ),
          ),
        ],
      )
    );
  }
}
