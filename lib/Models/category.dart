import 'dart:convert';

fromCatsJson(Map<String, dynamic> json) =>
    List<Category>.from(json['EBOOK_APP'].map((x) => Category.fromJson(x)));

String toCatsJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));



class Category {
  Category({
    required this.cid,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryImageThumb,
    required this.totalBooks,
  });

  String cid;
  String categoryName;
  String categoryImage;
  String categoryImageThumb;
  String totalBooks;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    cid: json['cid'],
    categoryName: json['category_name'],
    categoryImage: json['category_image'],
    categoryImageThumb: json['category_image_thumb'],
    totalBooks: json['total_books'],
  );

  Map<String, dynamic> toJson() => {
    'cid': cid,
    'category_name': categoryName,
    'category_image': categoryImage,
    'category_image_thumb': categoryImageThumb,
    'total_books': totalBooks,
  };
}

