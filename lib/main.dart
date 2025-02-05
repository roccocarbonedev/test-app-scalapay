import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app_scalapay/constants/routes/routes.dart';
import 'package:test_app_scalapay/view/pages/search_products_page/search_products_page.dart';

void main() {
 runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: RouteNames.search_products_page,
        builder: (BuildContext context, GoRouterState state) {
          return const SearchProductsPage();
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Test App Scalapay',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
