import 'package:apps/pages/home/home_bloc.dart';
import 'package:apps/pages/home/home_event.dart';
import 'package:apps/pages/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadedState) {
          return Column(children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    //https://uigradients.com/#CoolSky
                    colors: [
                      Color.fromRGBO(41, 128, 185, 1),
                      Color.fromRGBO(109, 213, 250, 1),
                    ],
                  ),
                ),
                child: DataWidget(
                    "Total de Vacinados",
                    state.data.fmtNumber(state.data.vaccinated),
                    'Vacinados por 100 mil habitantes',
                    state.data
                        .fmtNumber(state.data.vaccinatedPer100kInhabitants),
                    'Novos casos',
                    state.data.fmtNumber(state.data.newCases),
                    Colors.white),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  //https://uigradients.com/#CoolSky
                  colors: [
                    Color.fromRGBO(41, 128, 185, 1),
                    Color.fromRGBO(241, 39, 17, 1),
                  ],
                ),
              ),
              child: Text(
                'Atualizado em: ' + state.data.fmtDate(),
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    //https://uigradients.com/#Flare
                    colors: [
                      Color.fromRGBO(241, 39, 17, 1),
                      Color.fromRGBO(245, 175, 25, 1),
                    ],
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: DataWidget(
                      "Total de Mortes",
                      state.data.fmtNumber(state.data.deaths),
                      'Mortes por 100 mil habitantes',
                      state.data.fmtNumber(state.data.deathsPer100kInhabitants),
                      'Novas mortes',
                      state.data.fmtNumber(state.data.newDeaths),
                      Colors.white),
                ),
              ),
            ),
          ]);
        }
        if (state is HomeError) {
          return ErrorWidget();
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class DataWidget extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final String value2;
  final String label2;
  final String value3;
  final String label3;

  DataWidget(this.label, this.value, this.label2, this.value2, this.label3,
      this.value3, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListTile(
          title: Text(this.value,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: this.color,
                  fontSize: 35)),
          subtitle: Text(
            this.label,
            style: TextStyle(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ),
        ListTile(
          minVerticalPadding: 30,
          title: Text(this.value3,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: this.color,
                  fontSize: 35)),
          subtitle: Text(
            this.label3,
            style: TextStyle(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ),
        ListTile(
          minVerticalPadding: 5,
          title: Text(this.value2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: this.color,
                  fontSize: 35)),
          subtitle: Text(
            this.label2,
            style: TextStyle(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Problema ao carregar os dados!',
                  style: const TextStyle(color: Colors.white70, fontSize: 20),
                  textDirection: TextDirection.ltr,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15)),
                  onPressed: () {
                    BlocProvider.of<HomeBloc>(context)
                        .add(FetchHomeDataEvent("ALL"));
                  },
                  child: const Text('Tentar novamente'),
                ),
              ]),
        ));
  }
}
