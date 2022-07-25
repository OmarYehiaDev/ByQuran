import 'dart:convert';

//  Entry.fromJson(Map<String, dynamic> json) => Entry(
// ebookApp: List<EbookApp>.from(
// json['EBOOK_APP'].map((x) => EbookApp.fromJson(x))),
// );

fromJson(Map<String, dynamic> json) =>
    List<Ebook>.from(json['EBOOK_APP'].map((x) => Ebook.fromJson(x)));
//
// List<Ebook> fromJson(String str) =>
//     List<Ebook>.from(json.decode(str).map((x) => Ebook.fromJson(x)));

String toJson(List<Ebook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));




class Ebook {
  Ebook({
    required this.id,
    required this.catId,
    required this.aid,
    required this.bookTitle,
    // required this.bookPages,
    required this.bookDescription,
    required this.bookCoverImg,
    required this.bookBgImg,
    required this.bookFileType,
    required this.bookFileUrl,
    required this.totalRate,
    required this.rateAvg,
    required this.bookViews,
    required this.authorId,
    required this.authorName,
    required this.authorDescription,
    required this.cid,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryImageThumb,
  });

  String id;
  String catId;
  String aid;
  String bookTitle;
  // int bookPages;
  String bookDescription;
  String bookCoverImg;
  String bookBgImg;
  String bookFileType;
  String bookFileUrl;
  String totalRate;
  String rateAvg;
  String bookViews;
  String authorId;
  String authorName;
  String authorDescription;
  String cid;
  String categoryName;
  String categoryImage;
  String categoryImageThumb;

  factory Ebook.fromJson(Map<String, dynamic> json) => Ebook(
    id: json['id'],
    catId: json['cat_id'],
    aid: json['aid'],
    bookTitle: json['book_title'],
    // bookPages: json['book_pages'],
    bookDescription: json['book_description'],
    bookCoverImg: json['book_cover_img'].toString(),
    bookBgImg: json['book_bg_img'].toString(),
    bookFileType: json['book_file_type'],
    bookFileUrl: json['book_file_url'],
    totalRate: json['total_rate'],
    rateAvg: json['rate_avg'],
    bookViews: json['book_views'],
    authorId: json['author_id'],
    authorName: json['author_name'],
    authorDescription: json['author_description'],
    cid: json['cid'],
    categoryName: json['category_name'],
    categoryImage: json['category_image'],
    categoryImageThumb: json['category_image_thumb'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'cat_id': catId,
    'aid': aid,
    'book_title': bookTitle,
    // 'book_pages': bookPages,
    'book_description': bookDescription,
    'book_cover_img': bookCoverImg,
    'book_bg_img': bookBgImg,
    'book_file_type': bookFileType,
    'book_file_url': bookFileUrl,
    'total_rate': totalRate,
    'rate_avg': rateAvg,
    'book_views': bookViews,
    'author_id': authorId,
    'author_name': authorName,
    'author_description': authorDescription,
    'cid': cid,
    'category_name': categoryName,
    'category_image': categoryImage,
    'category_image_thumb': categoryImageThumb,
  };
}
