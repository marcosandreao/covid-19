import 'package:apps/api/model/data.dart';
import 'package:apps/pages/home/home_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:apps/api/vacination_api.dart';
import 'package:apps/pages/home/home_bloc.dart';
import 'package:apps/pages/home/home_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_bloc.test.mocks.dart';

@GenerateMocks([VacinationAPI])
void main() {
  Data fakeData() {
    return Data(
        date: '',
        deaths: 1,
        deathsByTotalCases: 1.0,
        deathsPer100kInhabitants: 1.0,
        newCases: 1,
        newDeaths: 1,
        testsPer100kInhabitants: 1.0,
        totalCases: 1,
        vaccinated: 1,
        vaccinatedPer100kInhabitants: 1.0);
  }

  Data data = fakeData();

  group('Home bloc', () {
    blocTest<HomeBloc, HomeState>(
      'test fetch home data event ALL',
      build: () {
        final client = MockVacinationAPI();
        when(client.getData("TOTAL")).thenAnswer((_) async => data);
        final bloc = HomeBloc(client);
        return bloc;
      },
      act: (bloc) => bloc.add(FetchHomeDataEvent("ALL")),
      expect: () => [HomeLoadingState(), HomeLoadedState(data)],
    );
    blocTest<HomeBloc, HomeState>(
      'test fetch home data event CUSTOM FILTER',
      build: () {
        final client = MockVacinationAPI();
        final bloc = HomeBloc(client);
        when(client.getData("BR")).thenAnswer((_) async => data);
        return bloc;
      },
      act: (bloc) => bloc.add(FetchHomeDataEvent("BR")),
      expect: () => [HomeLoadingState(), HomeLoadedState(data)],
    );
    blocTest<HomeBloc, HomeState>(
      'test throw erro (fetch data)',
      build: () {
        final client = MockVacinationAPI();
        final bloc = HomeBloc(client);
        when(client.getData("BR")).thenThrow(Error());
        return bloc;
      },
      act: (bloc) => bloc.add(FetchHomeDataEvent("BR")),
      expect: () => [HomeLoadingState(), HomeError()],
    );
  });
}
