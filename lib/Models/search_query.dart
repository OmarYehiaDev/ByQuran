import 'dart:convert';

class SearchQuery {
  SearchQuery({
    required this.surahNum,
    required this.surahTitle,
    required this.pageNum,
    required this.pageText,
    required this.pageImg,
    required this.pageFile,
    required this.mainFile,
  });
  String surahNum;
  String surahTitle;
  String pageNum;
  String pageText;
  String pageImg;
  String pageFile;
  String mainFile;

  factory SearchQuery.fromJson(Map<String, dynamic> json) => SearchQuery(
        mainFile: json['main_file'] ?? "",
        pageFile: json['page_file'],
        pageImg: json['page_img'],
        pageNum: json['page_number'],
        pageText: json['page_text'],
        surahNum: json['surah_no'] ?? "",
        surahTitle: json['book_title'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        'main_file': mainFile,
        'page_file': pageFile,
        'page_img': pageImg,
        'page_number': pageNum,
        'page_text': pageText,
        'surah_no': surahNum,
        'book_title': surahTitle,
      };
}

fromJsonAPI(Map<String, dynamic> json) => List<SearchQuery>.from(
      json['EBOOK_APP'].map(
        (x) => SearchQuery.fromJson(x),
      ),
    );
List<SearchQuery> fromJsonString(String str) => List<SearchQuery>.from(
      json.decode(str).map(
            (x) => SearchQuery.fromJson(x),
          ),
    );

String toJson(List<SearchQuery> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
