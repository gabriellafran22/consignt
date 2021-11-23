class Province {
  Province({
    this.provinceId,
    this.province,
  });

  String? provinceId;
  String? province;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        provinceId: json["province_id"],
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "province": province,
      };
}
