import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/saved/cubit/saved_cubit.dart';
import 'package:news_app/saved/widgets/empty_animation.dart';
import 'package:news_app/saved/widgets/saved_item.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          "Saved",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocBuilder<SavedCubit, List<ArticleModel>>(
        builder: (context, saved) {
          if (saved.isEmpty) {
            return const EmptyAnimation();
          }
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            physics: const BouncingScrollPhysics(),
            itemCount: saved.length,
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(color: Colors.grey, thickness: 0.5),
            ),
            itemBuilder: (context, index) => SavedItem(model: saved[index]),
          );
        },
      ),
    );
  }
}
