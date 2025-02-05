import 'package:flutter/material.dart';
import 'package:test_app_scalapay/constants/colors/colors.dart';

class CustomSearchBarWidget extends StatefulWidget {
  final Function(String) onSearch;

  const CustomSearchBarWidget({super.key, required this.onSearch});

  @override
  _CustomSearchBarWidgetState createState() => _CustomSearchBarWidgetState();
}

class _CustomSearchBarWidgetState extends State<CustomSearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.text.trim().isEmpty) {
        widget.onSearch('nike');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: "Nike",
        suffixIcon: GestureDetector(
          onTap: () {
            final query = _controller.text.trim();
            widget.onSearch(query.isEmpty ? 'nike' : query);
          },
          child: Container(
            margin: const EdgeInsets.only(right: 4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(CustomColors.blue),
            ),
            child: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
        filled: true,
        fillColor: const Color(CustomColors.backgroundColor),
        contentPadding: const EdgeInsets.all(16),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(1000.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(1000.0)),
          borderSide: BorderSide(
            color: Color(CustomColors.borderSearchBar),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(1000.0)),
          borderSide: BorderSide(
            color: Color(CustomColors.borderSearchBar),
          ),
        ),
      ),
    );
  }
}
