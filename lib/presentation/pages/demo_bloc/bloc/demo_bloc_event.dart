part of 'demo_bloc_bloc.dart';

sealed class DemoBlocEvent extends Equatable {
  const DemoBlocEvent();

  @override
  List<Object> get props => [];
}

class DemoFetchDataEvent extends DemoBlocEvent {
  final int time;

  const DemoFetchDataEvent({required this.time});
}

class StartTimerEvent extends DemoBlocEvent {
  const StartTimerEvent();
}

class UpdateCountEvent extends DemoBlocEvent {
  final int count;

  const UpdateCountEvent({required this.count});
}
