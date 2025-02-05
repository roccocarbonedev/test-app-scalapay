import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app_scalapay/data/api/product_service.dart';
import 'package:test_app_scalapay/data/models/product.dart';

class SearchProductsPageProvider
    extends StateNotifier<AsyncValue<List<Product>>> {
  final ProductService _productService;
  String _currentQuery = 'nike';
  double? _minPrice;
  double? _maxPrice;
  String _sortBy = '_text_match';
  String _sortDirection = 'desc';

  SearchProductsPageProvider(this._productService)
      : super(const AsyncValue.loading()) {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    state = const AsyncValue.loading();

    try {
      final searchResponse = await _productService.fetchProducts(
        query: _currentQuery,
        minPrice: _minPrice,
        maxPrice: _maxPrice,
        sortBy: _sortBy,
        sortDirection: _sortDirection,
      );
      state = AsyncValue.data(searchResponse.products);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void updateQuery(String query) {
    _currentQuery = query;
    fetchProducts();
  }

  void setFilters({double? minPrice, double? maxPrice}) {
    _minPrice = minPrice;
    _maxPrice = maxPrice;
  }

  void applyFilters() {
    fetchProducts();
  }

  void setSorting({required String sortBy, required String sortDirection}) {
    _sortBy = sortBy;
    _sortDirection = sortDirection;
    fetchProducts();
  }

  String getSortingKey() {
    if (_sortBy == "selling_price" && _sortDirection == "asc") return "Prezzo crescente";
    if (_sortBy == "selling_price" && _sortDirection == "desc") return "Prezzo decrescente";
    if (_sortBy == "_text_match" && _sortDirection == "asc") return "Nome A-Z";
    return "Nome Z-A";
  }
  
}

final searchPageProvider = StateNotifierProvider<SearchProductsPageProvider,
    AsyncValue<List<Product>>>((ref) {
  return SearchProductsPageProvider(ProductService());
});
