import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app_scalapay/constants/colors/colors.dart';
import 'package:test_app_scalapay/providers/search_products_page_provider.dart';
import 'package:test_app_scalapay/view/widgets/custom_filter_sort_widget.dart';
import 'package:test_app_scalapay/view/widgets/custom_product_card.dart';
import 'package:test_app_scalapay/view/widgets/custom_search_bar_widget.dart';

class SearchProductsPage extends ConsumerWidget {
  const SearchProductsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(CustomColors.backgroundColor),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              searchWidget(ref),
              const SizedBox(height: 10),
              filterSortBar(context, ref),
              const SizedBox(height: 10),
              gridViewProducts(ref)
            ],
          ),
        ),
      ),
    );
  }

  Widget searchWidget(WidgetRef ref) {
    final searchController = ref.read(searchPageProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Esplora i prodotti",
          style: GoogleFonts.poppins(
            color: const Color(CustomColors.primaryTextColor),
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        CustomSearchBarWidget(
          onSearch: (query) {
            searchController.updateQuery(query);
          },
        ),
      ],
    );
  }

  Widget filterSortBar(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomFilterSortWidget(
          asset: "assets/icons/filter.svg",
          title: "Filtri",
          onTap: () => _openFilterBottomSheet(context, ref),
        ),
        const SizedBox(
          width: 8,
        ),
        CustomFilterSortWidget(
          asset: "assets/icons/order.svg",
          title: "Ordina",
          onTap: () => _openSortBottomSheet(context, ref),
        ),
      ],
    );
  }

  Widget gridViewProducts(WidgetRef ref) {
    return Expanded(
      child: ref.watch(searchPageProvider).when(
            data: (products) => products.isNotEmpty
                ? GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.5,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return CustomProductCard(product: products[index]);
                    },
                  )
                : const Center(
                    child: Text("Nessun prodotto trovato"),
                  ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (e, _) => Center(
              child: Text('Errore: ${e.toString()}'),
            ),
          ),
    );
  }

  void _openFilterBottomSheet(BuildContext context, WidgetRef ref) {
    final provider = ref.read(searchPageProvider.notifier);
    final minController = TextEditingController();
    final maxController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(CustomColors.backgroudGray),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Filtri",
                style: GoogleFonts.poppins(
                  color: const Color(CustomColors.titleText),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fascia di prezzo",
                    style: GoogleFonts.poppins(
                      color: const Color(CustomColors.titleText),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: minController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "100",
                            labelText: "Minimo",
                            filled: true,
                            fillColor: Color(CustomColors.backgroundColor),
                            contentPadding: EdgeInsets.all(16),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(
                                color: Color(CustomColors.borderSearchBar),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(
                                color: Color(CustomColors.borderSearchBar),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text("-"),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: maxController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "2000",
                            labelText: "Massimo",
                            filled: true,
                            fillColor: Color(CustomColors.backgroundColor),
                            contentPadding: EdgeInsets.all(16),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(
                                color: Color(CustomColors.borderSearchBar),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(
                                color: Color(CustomColors.borderSearchBar),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        //TODO: REMOVE AL FILTERS
                      },
                      child: Text(
                        "Cancella tutto",
                        style: GoogleFonts.poppins(
                          color: const Color(CustomColors.blue),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      provider.setFilters(
                        minPrice: double.tryParse(minController.text),
                        maxPrice: double.tryParse(maxController.text),
                      );
                      provider.applyFilters();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(CustomColors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    child: Text(
                      "Mostra risultati",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openSortBottomSheet(BuildContext context, WidgetRef ref) {
    final selectedSorting =
        ref.watch(searchPageProvider.notifier).getSortingKey();
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(CustomColors.backgroudGray),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Ordina",
                style: GoogleFonts.poppins(
                  color: const Color(CustomColors.titleText),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: sortOptionsList(ref, selectedSorting),
            ),
          ],
        ),
      ),
    );
  }

  Widget sortOptionsList(WidgetRef ref, String selectedSorting) {
    final provider = ref.read(searchPageProvider.notifier);

    final List<Map<String, String>> options = [
      {
        "label": "Prezzo crescente",
        "sortBy": "selling_price",
        "sortDirection": "asc"
      },
      {
        "label": "Prezzo decrescente",
        "sortBy": "selling_price",
        "sortDirection": "desc"
      },
      {
        "label": "Nome A-Z",
        "sortBy": "_text_match",
        "sortDirection": "asc",
      },
      {
        "label": "Nome Z-A",
        "sortBy": "_text_match",
        "sortDirection": "desc",
      },
    ];

    return Column(
      children: options.map((option) {
        return Column(
          children: [
            RadioListTile<String>(
              title: Text(
                option["label"]!,
                style: GoogleFonts.poppins(
                  color: const Color(CustomColors.titleText),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: option["label"]!,
              groupValue: selectedSorting,
              activeColor: Colors.blue,
              onChanged: (value) {
                provider.setSorting(
                  sortBy: option["sortBy"]!,
                  sortDirection: option["sortDirection"]!,
                );
                Navigator.pop(ref.context);
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(thickness: 0.5),
            ),
          ],
        );
      }).toList(),
    );
  }
}
