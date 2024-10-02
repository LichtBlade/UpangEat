part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryLoading extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;

  const CategoryLoaded(this.categories);
  @override
  List<Object> get props => [categories];
}

final class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);
  @override
  List<Object> get props => [message];
}
