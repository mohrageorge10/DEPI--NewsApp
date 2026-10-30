import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api_constants.dart';
import 'package:news_app/models/article_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  // ============= Dio Object =============
  final dio = Dio();

  int _requestId = 0;

  // ============= Categories =============
  static const Map<String, Map<String, String>> _categoryParams = {
    "All": {},
    "Politic": {"q": "politics"},
    "Sport": {"category": "sports"},
    "Education": {"q": "education"},
    "Health": {"category": "health"},
    "Business": {"category": "business"},
    "Entertainment": {"category": "entertainment"},
    "Science": {"category": "science"},
  };

  // ============= Get Home Data =============
  String currentCategory = "All";

  Future<void> getHomeData({String category = "All"}) async {
    final int id = ++_requestId;
    currentCategory = category;
    try {
      emit(HomeLoading());
      final Response response = await dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.topHeadlines}",
        queryParameters: {
          ApiConstants.country: "us",
          ApiConstants.apiKey: ApiConstants.apiKeyValue,
          ...?_categoryParams[category],
        },
      );

      final articles = response.data[ApiConstants.articles] as List;
      final data = articles.map((art) => ArticleModel.fromJson(art)).toList();

      if (isClosed || id != _requestId) return;
      emit(HomeSuccess(data));
    } on DioException catch (e) {
      if (isClosed || id != _requestId) return;
      emit(HomeFailure(e.message ?? "Error found"));
    } catch (e) {
      if (isClosed || id != _requestId) return;
      emit(HomeFailure(e.toString()));
    }
  }

  // ============= Get Search Data =============
  Future<void> getSearchData({required String query}) async {
    try {
      emit(HomeLoading());
      final Response response = await dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.everything}",
        queryParameters: {
          "q": query,
          ApiConstants.apiKey: ApiConstants.apiKeyValue,
        },
      );

      final data = (response.data[ApiConstants.articles] as List)
          .map((art) => ArticleModel.fromJson(art))
          .toList();

      emit(HomeSuccess(data));
    } on DioException catch (e) {
      emit(HomeFailure(e.message ?? "Error found"));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
