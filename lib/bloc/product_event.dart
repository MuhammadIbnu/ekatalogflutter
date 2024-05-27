abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

class FetchProductDetail extends ProductEvent {
  final int productId;

  FetchProductDetail(this.productId);
}
