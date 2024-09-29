import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/category_model.dart';
import '../../repositories/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryBloc(this._categoryRepository) : super(CategoryInitial()) {
    on<LoadCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        final categories = await _categoryRepository.fetchCategory();
        emit(CategoryLoaded(categories));
      } catch(error) {
        emit(CategoryError(error.toString()));
      }
    });
  }
}
