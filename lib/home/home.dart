import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home/cubit/home_cubit.dart';
import 'package:news_app/home/widgets/articles.dart';
import 'package:news_app/home/widgets/header.dart';
import 'package:news_app/home/widgets/img_error.dart';
import 'package:news_app/home/widgets/news_categories.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const List<String> categories = [
    "All",
    "Politic",
    "Sport",
    "Education",
    "Health",
    "Business",
    "Entertainment",
    "Science",
  ];

  @override
  Widget build(BuildContext context) {
    // 1. BlocProvider on Scaffold
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const Drawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.black),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            ),
          ],
        ),
        body: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const Header(title: "Breaking News"),
                  _BreakingNews(),
                  NewsCategories(
                    categories: categories,
                    onSelected: (category) => context
                        .read<HomeCubit>()
                        .getHomeData(category: category),
                  ),
                  const SizedBox(height: 8),
                  const Header(title: 'News For You'),
                  const SizedBox(height: 8),
                  Expanded(
                    child: _NewsList(
                      onRetry: () {
                        final cubit = context.read<HomeCubit>();
                        cubit.getHomeData(category: cubit.currentCategory);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ========== Breaking News ==========
class _BreakingNews extends StatelessWidget {
  static const double _height = 194;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: _height,
        width: double.infinity,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeSuccess && state.data.isNotEmpty) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  state.data[0].imgUrl ?? "",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const ImgError(h: _height),
                ),
              );
            }
            return const ImgError(h: _height);
          },
        ),
      ),
    );
  }
}

// ========== News For You  ==========
class _NewsList extends StatelessWidget {
  const _NewsList({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        // ========== Loading State ==========
        if (state is HomeLoading || state is HomeInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        // ========== Failure State ==========
        if (state is HomeFailure) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.errorMessage, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                TextButton(onPressed: onRetry, child: const Text("Retry")),
              ],
            ),
          );
        }

        // ========== Success State ==========
        if (state is HomeSuccess) {
          return Articles(articles: state.data.skip(1).toList());
        }
        return const SizedBox();
      },
    );
  }
}
