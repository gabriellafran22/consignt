import 'dart:convert';

import 'package:consignt/core/model/city.dart';

CityResponse cityResponseFromJson(String str) =>
    CityResponse.fromJson(json.decode(str));

String cityResponseToJson(CityResponse data) => json.encode(data.toJson());

class CityResponse {
  CityResponse({
    this.rajaongkir,
  });

  Rajaongkir? rajaongkir;

  factory CityResponse.fromJson(Map<String, dynamic> json) => CityResponse(
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

  Query? query;
  Status? status;
  List<City>? results;

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
        query: Query.fromJson(json["query"]),
        status: Status.fromJson(json["status"]),
        results: List<City>.from(json["results"].map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "query": query?.toJson(),
        "status": status?.toJson(),
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Query {
  Query({
    this.province,
  });

  String? province;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "province": province,
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
