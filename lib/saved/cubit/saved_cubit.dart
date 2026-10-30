import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/article_model.dart';

class SavedCubit extends Cubit<List<ArticleModel>> {
  SavedCubit() : super(const []);

  bool isSaved(ArticleModel article) =>
      state.any((saved) => saved.id == article.id);

  void toggle(ArticleModel article) {
    if (isSaved(article)) {
      emit(state.where((saved) => saved.id != article.id).toList());
    } else {
      emit([article, ...state]);
    }
  }
}
