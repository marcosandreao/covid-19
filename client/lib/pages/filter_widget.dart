import 'package:apps/api/model/city.dart';
import 'package:apps/pages/home/home_bloc.dart';
import 'package:apps/pages/home/home_event.dart';
import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  final HomeBloc bloc;
  FilterWidget({required this.bloc}) : super(key: Key('filter'));

  @override
  FilterStateWidget createState() => FilterStateWidget(this.bloc);
}

class FilterStateWidget extends State<FilterWidget> {
  City dropdownValue = City(code: "ALL", name: "Geral");

  final HomeBloc bloc;
  FilterStateWidget(this.bloc);

  List<City> cities = [];
  loadData() async {
    cities = await City.fromFile();
    this.dropdownValue = cities[0];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    var items = cities.map<DropdownMenuItem<City>>((City city) {
      return DropdownMenuItem<City>(
        key: Key(city.code),
        value: city,
        child: Text(city.name),
      );
    }).toList();
    if (cities.length > 0) {
      return DropdownButton<City>(
          value: dropdownValue,
          icon: const Icon(Icons.filter_alt_outlined),
          iconSize: 24,
          elevation: 16,
          underline: Container(
            height: 2,
            color: Colors.white24,
          ),
          onChanged: (City? newValue) {
            setState(() {
              this.dropdownValue = newValue!;
              this.bloc.add(FetchHomeDataEvent(this.dropdownValue.code));
            });
          },
          items: items);
    }
    return Container();
  }
}
