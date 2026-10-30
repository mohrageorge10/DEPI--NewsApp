import 'package:flutter/material.dart';
class SearchButton extends StatefulWidget {
  const SearchButton({
    super.key,
    required this.searchController,
    required this.onPressed,
  });
  final TextEditingController searchController;
  final VoidCallback onPressed;

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.searchController.text.isNotEmpty ? widget.onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff001F3F),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text("Search", style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  )),
    );
  }
}
