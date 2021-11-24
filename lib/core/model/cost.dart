class Cost {
  Cost({
    this.value,
    this.etd,
    this.note,
  });

  int? value;
  String? etd;
  String? note;

  factory Cost.fromJson(Map<String, dynamic> json) => Cost(
    value: json["value"],
    etd: json["etd"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "etd": etd,
    "note": note,
  };
}