import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class FetchHomeDataEvent extends HomeEvent {
  final String filter;
  const FetchHomeDataEvent(this.filter);

  @override
  List<Object> get props => [filter];
}
