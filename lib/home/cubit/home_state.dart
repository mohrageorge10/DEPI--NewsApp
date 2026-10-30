part of 'home_cubit.dart';

abstract class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}
final class HomeSuccess extends HomeState 
{
  final List<ArticleModel> data;
  HomeSuccess(this.data);
}
final class HomeFailure extends HomeState 
{
  final String errorMessage;
  HomeFailure(this.errorMessage);
}
