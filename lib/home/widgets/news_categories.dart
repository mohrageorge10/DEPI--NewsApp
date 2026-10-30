import 'package:flutter/material.dart';

class NewsCategories extends StatefulWidget {
  const NewsCategories({
    super.key,
    required this.categories,
    required this.onSelected,
  });

  final List<String> categories;

  final ValueChanged<String> onSelected;

  @override
  State<NewsCategories> createState() => _NewsCategoriesState();
}

class _NewsCategoriesState extends State<NewsCategories> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (index == selectedIndex) return;
              setState(() {
                selectedIndex = index;
              });
              widget.onSelected(widget.categories[index]);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                border: index == selectedIndex
                    ? Border.all(color: const Color(0xffFFA500))
                    : Border.all(color: Colors.black),
                color: index == selectedIndex
                    ? const Color(0xffFFA500)
                    : Colors.white,
              ),
              child: Text(
                widget.categories[index],
                style: index == selectedIndex
                    ? const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                    : const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: widget.categories.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
