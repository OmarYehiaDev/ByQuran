import 'dart:convert';

fromSurahsJson(Map<String, dynamic> json) =>
    List<Surah>.from(json['EBOOK_APP'].map((x) => Surah.fromJson(x)));

String toSurahsJson(List<Surah> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));



class Surah {
  Surah({
    required this.id,
    required this.surah,
  });

  String id;
  String surah;

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
    id: json['id'],
    surah: json['surah'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'surah': surah,
  };
}

