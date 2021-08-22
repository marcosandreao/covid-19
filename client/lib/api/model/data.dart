import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

@immutable
class Data {
  Data({
    required this.deaths,
    required this.deathsByTotalCases,
    required this.deathsPer100kInhabitants,
    required this.newCases,
    required this.newDeaths,
    required this.totalCases,
    required this.testsPer100kInhabitants,
    required this.vaccinated,
    required this.vaccinatedPer100kInhabitants,
    required this.date,
  });

  final int deaths;
  final double deathsByTotalCases;
  final double deathsPer100kInhabitants;

  final int newCases;
  final int newDeaths;

  final int totalCases;
  final double testsPer100kInhabitants;

  final int vaccinated;
  final double vaccinatedPer100kInhabitants;

  final String date;
  Data.fromSnapshot(Map<String, dynamic> json)
      : this(
          deaths: int.parse(json['deaths']! as String),
          deathsByTotalCases:
              double.parse(json['deaths_by_totalCases']! as String),
          deathsPer100kInhabitants:
              double.parse(json['deaths_per_100k_inhabitants']! as String),
          newCases: int.parse(json['newCases']! as String),
          newDeaths: int.parse(json['newDeaths']! as String),
          totalCases: int.parse(json['totalCases']! as String),
          testsPer100kInhabitants:
              double.parse(json['tests_per_100k_inhabitants']! as String),
          vaccinated: int.parse(json['vaccinated']! as String),
          vaccinatedPer100kInhabitants:
              double.parse(json['vaccinated_per_100_inhabitants']! as String),
          date: json['date']! as String,
        );

  String fmtDate() {
    var values = date.split('-');
    if (values.length < 3) {
      return '';
    }
    return values[2] + '/' + values[1] + '/' + values[0];
  }

  String fmtNumber(dynamic number) {
    return NumberFormat.compactLong().format(number);
  }
}
