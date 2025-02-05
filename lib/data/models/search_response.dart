import 'product.dart';

class SearchResponse {
  final int found;
  final List<Product> products;

  SearchResponse({
    required this.found,
    required this.products,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    List<Product> productList = [];

    if (json['grouped_hits'] != null) {
      for (var group in json['grouped_hits']) {
        for (var hit in group['hits']) {
          productList.add(Product.fromJson(hit['document']));
        }
      }
    }

    return SearchResponse(
      found: json['found'] ?? 0,
      products: productList,
    );
  }
}
