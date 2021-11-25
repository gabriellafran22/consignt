import 'dart:convert';

import 'package:consignt/core/model/result_cost.dart';

CostResponse costResponseFromJson(String str) =>
    CostResponse.fromJson(json.decode(str));

String costResponseToJson(CostResponse data) => json.encode(data.toJson());

class CostResponse {
  CostResponse({
    this.rajaongkir,
  });

  Rajaongkir? rajaongkir;

  factory CostResponse.fromJson(Map<String, dynamic> json) => CostResponse(
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
    this.originDetails,
    this.destinationDetails,
    this.results,
  });

  CostQuery? query;
  Status? status;
  NDetails? originDetails;
  NDetails? destinationDetails;
  List<Result>? results;

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
        query: CostQuery.fromJson(json["query"]),
        status: Status.fromJson(json["status"]),
        originDetails: NDetails.fromJson(json["origin_details"]),
        destinationDetails: NDetails.fromJson(json["destination_details"]),
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "query": query?.toJson(),
        "status": status?.toJson(),
        "origin_details": originDetails?.toJson(),
        "destination_details": destinationDetails?.toJson(),
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class NDetails {
  NDetails({
    this.cityId,
    this.provinceId,
    this.province,
    this.type,
    this.cityName,
    this.postalCode,
  });

  String? cityId;
  String? provinceId;
  String? province;
  String? type;
  String? cityName;
  String? postalCode;

  factory NDetails.fromJson(Map<String, dynamic> json) => NDetails(
        cityId: json["city_id"],
        provinceId: json["province_id"],
        province: json["province"],
        type: json["type"],
        cityName: json["city_name"],
        postalCode: json["postal_code"],
      );

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "province_id": provinceId,
        "province": province,
        "type": type,
        "city_name": cityName,
        "postal_code": postalCode,
      };
}

class CostQuery {
  CostQuery({
    this.origin,
    this.destination,
    this.weight,
    this.courier,
  });

  String? origin;
  String? destination;
  int? weight;
  String? courier;

  factory CostQuery.fromJson(Map<String, dynamic> json) => CostQuery(
        origin: json["origin"],
        destination: json["destination"],
        weight: json["weight"],
        courier: json["courier"],
      );

  Map<String, dynamic> toJson() => {
        "origin": origin,
        "destination": destination,
        "weight": weight,
        "courier": courier,
      };
}

class Result {
  Result({
    this.code,
    this.name,
    this.costs,
  });

  String? code;
  String? name;
  List<ResultCost>? costs;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        code: json["code"],
        name: json["name"],
        costs: List<ResultCost>.from(
            json["costs"].map((x) => ResultCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "costs": List<dynamic>.from(costs!.map((x) => x.toJson())),
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
