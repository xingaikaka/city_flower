import 'package:flutter/material.dart';

class CityFlower {
  final String cityId;
  final String cityName;
  final String province;
  final String flowerName;
  final String flowerAlias;
  final String latinName;
  final String designatedYear;
  final String designatedDate;
  final String flowerColor;
  final String bloomSeason;
  final String history;
  final String reason;
  final String meaning;
  final String imageAsset;
  final String emoji;
  final Color accentColor;

  const CityFlower({
    required this.cityId,
    required this.cityName,
    required this.province,
    required this.flowerName,
    required this.flowerAlias,
    required this.latinName,
    required this.designatedYear,
    required this.designatedDate,
    required this.flowerColor,
    required this.bloomSeason,
    required this.history,
    required this.reason,
    required this.meaning,
    required this.imageAsset,
    required this.emoji,
    required this.accentColor,
  });
}
