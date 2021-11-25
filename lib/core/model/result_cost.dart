import 'package:consignt/core/model/cost.dart';

class ResultCost {
  ResultCost({
    this.service,
    this.description,
    this.cost,
  });

  String? service;
  String? description;
  List<Cost>? cost;

  factory ResultCost.fromJson(Map<String, dynamic> json) => ResultCost(
        service: json["service"],
        description: json["description"],
        cost: List<Cost>.from(json["cost"].map((x) => Cost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service": service,
        "description": description,
        "cost": List<dynamic>.from(cost!.map((x) => x.toJson())),
      };
}
