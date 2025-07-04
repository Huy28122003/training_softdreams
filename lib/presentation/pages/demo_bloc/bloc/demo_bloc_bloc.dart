import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:training_softdreams/core/bloc/base_bloc.dart';

part 'demo_bloc_event.dart';

part 'demo_bloc_state.dart';

class DemoBlocBloc extends BaseBloc<DemoBlocEvent, DemoBlocState> {
  DemoBlocBloc() : super(DemoBlocState()) {
    on<DemoBlocEvent>((event, emit) {});
    on<DemoFetchDataEvent>(_onFetchData);
    on<StartTimerEvent>(_onStartTimer);
    on<UpdateCountEvent>(_onUpdateCount);
  }

  Timer? _timer;

  void initialize(int time) {
    add(DemoFetchDataEvent(time: time));
  }

  void onStartTimer() {
    add(StartTimerEvent());
  }

  void dispose(){
    _timer?.cancel();
  }

  Future<void> _onFetchData(
    DemoFetchDataEvent event,
    Emitter<DemoBlocState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    await Future.delayed(Duration(seconds: 2));

    emit(state.copyWith(status: FormzSubmissionStatus.success));

    // emit(state.copyWith(status: FormzSubmissionStatus.failure));
  }

  void _onStartTimer(
    StartTimerEvent event,
    Emitter<DemoBlocState> emit,
  ) {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final count = state.count + 1;
      add(UpdateCountEvent(count: count));

      // Su khac bit giua bloc va cubit
      // emit(state.copyWith(count: count));
    });
  }

  void _onUpdateCount(UpdateCountEvent event, Emitter<DemoBlocState> emit) {
    emit(state.copyWith(count: event.count));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
