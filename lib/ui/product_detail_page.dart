import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../repositories/product_repository.dart';

class ProductDetailPage extends StatelessWidget {
  final int productId;

  ProductDetailPage({required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Detail')),
      body: BlocProvider(
        create: (context) => ProductBloc(
          productRepository: context.read<ProductRepository>(),
        )..add(FetchProductDetail(productId)),
        child: ProductDetailView(),
      ),
    );
  }
}

class ProductDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProductDetailLoaded) {
          final product = state.product;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  product.image,
                  height: 200,
                  width: double.infinity, 
                  fit: BoxFit.contain, 
                ),
                SizedBox(height: 16),
                Text(product.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('\$${product.price}', style: TextStyle(fontSize: 20)),
                SizedBox(height: 16),
                Text(product.description),
              ],
            ),
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
