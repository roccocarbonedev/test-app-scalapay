import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:test_app_scalapay/data/api/product_service.dart';
import './products_mock.dart';
import 'product_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late ProductService productService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    productService = ProductService();
    productService = ProductService(dio: mockDio);
  });

  test('fetchProducts restituisce una lista di prodotti', () async {
    when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async => Response(
              data: ProductsMock.fakeResponse,
              statusCode: 200,
              requestOptions: RequestOptions(path: ''),
            ));

    final result = await productService.fetchProducts(query: 'ciao');

    expect(result.products.length, 2);
    expect(
        result.products.first.title, "NIKE SKILLS NEXT NATURE Pallone Basket");
    expect(result.products.last.sellingPrice, 11.95);
  });

  test('fetchProducts restituisce lista vuota se nessun prodotto trovato',
      () async {
    when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async => Response(
              data: ProductsMock.emptyResponse,
              statusCode: 200,
              requestOptions: RequestOptions(path: ''),
            ));

    final result =
        await productService.fetchProducts(query: 'nonexistentproduct');

    expect(result.products.isEmpty, true);
  });
}
