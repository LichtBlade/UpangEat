import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int foodItemId;
  final int categoryId;

  const CategoryModel({required this.foodItemId, required this.categoryId});

  factory CategoryModel.fromJson(Map<String, dynamic> json){
    return CategoryModel(
      foodItemId: json['food_item_id'],
      categoryId: json['category_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'food_item_id' : foodItemId,
      'category_id' : categoryId
    };
  }


  @override
  List<Object?> get props => [foodItemId, categoryId];
}