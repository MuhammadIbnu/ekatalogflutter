import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../repositories/product_repository.dart';
import 'product_detail_page.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Catalog')),
      body: BlocProvider(
        create: (context) => ProductBloc(
          productRepository: context.read<ProductRepository>(),
        )..add(FetchProducts()),
        child: ProductListView(),
      ),
    );
  }
}

class ProductListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProductsLoaded) {
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ListTile(
                title: Text(product.title),
                subtitle: Text('\$${product.price}'),
                leading: Image.network(product.image, width: 50, height: 50),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailPage(productId: product.id),
                    ),
                  );
                },
              );
            },
          );
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }
}
