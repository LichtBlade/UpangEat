import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int categoryId;
  final String categoryName;
  final String? imageUrl;

  const CategoryModel(
      {required this.categoryId,
      required this.categoryName,
      required this.imageUrl});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        categoryId: json['category_id'],
        categoryName: json['category_name'],
        imageUrl: json['image_url'] ?? "assets/1.jpg");
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'category_name': categoryName,
      'image_url': imageUrl
    };
  }

  @override
  List<Object?> get props => [categoryName, categoryId, imageUrl];
}
