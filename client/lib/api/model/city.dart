import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

@immutable
class City {
  final String code;

  final String name;

  City({required this.code, required this.name});

  City.fromJson(Map<String, dynamic> json)
      : this(code: json['code']! as String, name: json['name']! as String);

  static Future<List<City>> fromFile() async {
    String json = await rootBundle.loadString('assets/cities.json');
    List<dynamic> itens = jsonDecode(json);
    List<City> cities = [];
    cities.add(City(code: 'ALL', name: 'Geral'));
    for (var item in itens) {
      cities.add(City.fromJson(item));
    }
    return cities;
  }
}
