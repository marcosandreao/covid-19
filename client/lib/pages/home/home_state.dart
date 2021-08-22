import 'package:apps/api/model/data.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();

  @override
  List<Object> get props => [];
}

class HomeLoadedState extends HomeState {
  final Data data;

  const HomeLoadedState(this.data);

  @override
  List<Object> get props => [data];
}

class HomeError extends HomeState {
  @override
  List<Object?> get props => [];
}
