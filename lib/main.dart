import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repositories/product_repository.dart';
import 'ui/product_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepository(),
        ),
      ],
      child: MaterialApp(
        title: 'Product Catalog',
        home: ProductListPage(),
      ),
    );
  }
}
