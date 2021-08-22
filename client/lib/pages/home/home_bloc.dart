import 'package:apps/api/vacination_api.dart';
import 'package:apps/pages/home/home_event.dart';
import 'package:apps/pages/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final VacinationAPI apiClient;

  HomeBloc(this.apiClient) : super(HomeLoadingState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is FetchHomeDataEvent) {
      yield HomeLoadingState();
      try {
        var _filter = event.filter == "ALL" ? "TOTAL" : event.filter;
        final data = await apiClient.getData(_filter);
        yield HomeLoadedState(data);
      } catch (err) {
        print(err);
        yield HomeError();
      }
    }
  }
}
