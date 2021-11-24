import 'dart:convert';

import 'package:consignt/core/model/city.dart';

AllCityResponse allCityResponseFromJson(String str) =>
    AllCityResponse.fromJson(json.decode(str));

String cityResponseToJson(AllCityResponse data) => json.encode(data.toJson());

class AllCityResponse {
  AllCityResponse({
    this.rajaongkir,
  });

  Rajaongkir? rajaongkir;

  factory AllCityResponse.fromJson(Map<String, dynamic> json) =>
      AllCityResponse(
        rajaongkir: Rajaongkir.fromJson(json["rajaongkir"]),
      );

  Map<String, dynamic> toJson() => {
        "rajaongkir": rajaongkir?.toJson(),
      };
}

class Rajaongkir {
  Rajaongkir({
    this.status,
    this.results,
  });

  Status? status;
  List<City>? results;

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
        status: Status.fromJson(json["status"]),
        results: List<City>.from(json["results"].map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
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
