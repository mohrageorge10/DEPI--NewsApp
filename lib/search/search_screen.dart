import 'package:flutter/material.dart';
import 'package:news_app/search/search_mixin.dart';
import 'package:news_app/search/search_results.dart';
import 'package:news_app/search/widgets/search_bar.dart';
import 'package:news_app/search/widgets/search_button.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SearchMixin {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchBarWidget(
                searchController: searchController,
                focusNode: searchFocusNode,
              ),
              SizedBox(height: 100),
              SearchButton(
                searchController: searchController,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchResults(query: searchController.text),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
