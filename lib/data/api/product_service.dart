import 'package:dio/dio.dart';
import 'package:test_app_scalapay/data/models/search_response.dart';

class ProductService {
  Dio _dio = Dio();
  final String _baseUrl =
      'https://catalog-api.dev-cat.scalapay.com/v1/products/search';

        ProductService({Dio? dio}) : _dio = dio ?? Dio();


  Future<SearchResponse> fetchProducts({
    String query = 'nike',
    int perPage = 30,
    int page = 1,
    double? minPrice,
    double? maxPrice,
    String sortBy = '_text_match',
    String sortDirection = 'desc',
  }) async {
    try {
      final Map<String, dynamic> queryParams = {
        'q': query,
        'per_page': perPage,
        'page': page,
        'sort_by': '$sortBy:$sortDirection',
      };

      if (minPrice != null) {
        queryParams['minPrice'] = minPrice;
      }
      if (maxPrice != null) {
        queryParams['maxPrice'] = maxPrice;
      }

      final response = await _dio.get(_baseUrl, queryParameters: queryParams);

      if (response.statusCode == 200) {
        return SearchResponse.fromJson(response.data);
      } else {
        throw Exception(
            "Errore durante il recupero dei dati: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Errore durante la richiesta: $e");
    }
  }
}
