import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app_scalapay/constants/colors/colors.dart';
import 'package:test_app_scalapay/data/models/product.dart';

class CustomProductCard extends StatelessWidget {
  final Product product;
  const CustomProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 195,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
            image: DecorationImage(image: NetworkImage(product.image),)
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                style: GoogleFonts.poppins(
                  color: const Color(CustomColors.titleText),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Text(
                product.merchant,
                style: GoogleFonts.poppins(
                  color: const Color(CustomColors.merchantProductCard),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 4),
              Text(
                "${(product.sellingPrice).toStringAsFixed(2)}€ or",
                style: GoogleFonts.poppins(
                  color: const Color(CustomColors.fullPriceProductCard),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Text(
                "3 installments of €${(product.sellingPrice / 3).toStringAsFixed(2)}",
                style: GoogleFonts.poppins(
                  color: const Color(CustomColors.blue),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
