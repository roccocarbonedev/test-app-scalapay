import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app_scalapay/constants/colors/colors.dart';

class CustomFilterSortWidget extends StatelessWidget {
  final String asset;
  final String title;
  final VoidCallback onTap;

  const CustomFilterSortWidget({
    super.key,
    required this.asset,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(CustomColors.backgroudGray),
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              asset,
              height: 20,
              width: 20,
            ),
            const SizedBox(width: 2),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: const Color(CustomColors.titleText),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
