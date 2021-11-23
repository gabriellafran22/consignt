import 'dart:convert';

import 'package:consignt/core/model/province.dart';

ProvinceResponse provinceResponseFromJson(String str) =>
    ProvinceResponse.fromJson(json.decode(str));

String provinceResponseToJson(ProvinceResponse data) =>
    json.encode(data.toJson());

class ProvinceResponse {
  ProvinceResponse({
    this.rajaongkir,
  });

  Rajaongkir? rajaongkir;

  factory ProvinceResponse.fromJson(Map<String, dynamic> json) =>
      ProvinceResponse(
        rajaongkir: Rajaongkir.fromJson(json["rajaongkir"]),
      );

  Map<String, dynamic> toJson() => {
        "rajaongkir": rajaongkir?.toJson(),
      };
}

class Rajaongkir {
  Rajaongkir({
    this.query,
    this.status,
    this.results,
  });

  List<dynamic>? query;
  Status? status;
  List<Province>? results;

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
        query: List<dynamic>.from(json["query"].map((x) => x)),
        status: Status.fromJson(json["status"]),
        results: List<Province>.from(
            json["results"].map((x) => Province.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "query": List<dynamic>.from(query!.map((x) => x)),
        "status": status?.toJson(),
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Status {
  Status({
    this.code,
    this.description,
  });

  int? code;
  String? description;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json["code"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
      };
}
