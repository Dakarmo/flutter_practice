import 'package:flutter/material.dart';
import 'package:medical_heathcare/providers/product_provider.dart';
import 'package:medical_heathcare/widgets/product_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductProvider>(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductScreen(),

      ),

    );
  }
}
