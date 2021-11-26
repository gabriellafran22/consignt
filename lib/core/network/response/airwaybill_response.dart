import 'dart:convert';

AirwayBillResponse airwayBillResponseFromJson(String str) =>
    AirwayBillResponse.fromJson(json.decode(str));

String airwayBillResponseToJson(AirwayBillResponse data) =>
    json.encode(data.toJson());

var historyNull = [
  {"date": "", "desc": "", "location": ""}
];

class AirwayBillResponse {
  AirwayBillResponse({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory AirwayBillResponse.fromJson(Map<String, dynamic> json) =>
      AirwayBillResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.summary,
    this.detail,
    this.history,
  });

  Summary? summary;
  Detail? detail;
  List<History>? history;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        summary: Summary.fromJson(json["summary"]),
        detail: Detail.fromJson(json["detail"]),
        history: json["history"] == null
            ? List<History>.from(historyNull.map((x) => History.fromJson(x)))
            : List<History>.from(
                json["history"].map((x) => History.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "summary": summary?.toJson(),
        "detail": detail?.toJson(),
        "history": List<dynamic>.from(history!.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    this.origin,
    this.destination,
    this.shipper,
    this.receiver,
  });

  String? origin;
  String? destination;
  String? shipper;
  String? receiver;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        origin: json["origin"],
        destination: json["destination"],
        shipper: json["shipper"],
        receiver: json["receiver"],
      );

  Map<String, dynamic> toJson() => {
        "origin": origin,
        "destination": destination,
        "shipper": shipper,
        "receiver": receiver,
      };
}

class History {
  History({
    this.date,
    this.desc,
    this.location,
  });

  String? date;
  String? desc;
  String? location;

  factory History.fromJson(Map<String, dynamic> json) => History(
        date: json["date"],
        desc: json["desc"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "desc": desc,
        "location": location,
      };
}

class Summary {
  Summary({
    this.awb,
    this.courier,
    this.service,
    this.status,
    this.date,
    this.desc,
    this.amount,
    this.weight,
  });

  String? awb;
  String? courier;
  String? service;
  String? status;
  String? date;
  String? desc;
  String? amount;
  String? weight;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        awb: json["awb"],
        courier: json["courier"],
        service: json["service"],
        status: json["status"],
        date: json["date"],
        desc: json["desc"],
        amount: json["amount"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "awb": awb,
        "courier": courier,
        "service": service,
        "status": status,
        "date": date,
        "desc": desc,
        "amount": amount,
        "weight": weight,
      };
}
