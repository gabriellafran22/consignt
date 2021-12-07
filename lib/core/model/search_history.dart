import 'dart:convert';

SearchHistoryModel searchHistoryFromJson(String str) => SearchHistoryModel.fromJson(json.decode(str));

String searchHistoryToJson(SearchHistoryModel data) => json.encode(data.toJson());

class SearchHistoryModel {
  SearchHistoryModel({
    this.id,
    required this.searchQuery,
  });

  int? id;
  String searchQuery;

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) => SearchHistoryModel(
    id: json["id"],
    searchQuery: json["searchQuery"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "searchQuery": searchQuery,
  };
}
