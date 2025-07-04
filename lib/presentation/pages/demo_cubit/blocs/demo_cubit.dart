import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:training_softdreams/core/bloc/base_cubit.dart';

part 'demo_state.dart';

class DemoCubit extends BaseCubit<DemoState> {
  DemoCubit() : super(DemoState());

  Future<void> onFetchData() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    await Future.delayed(Duration(seconds: 2));

    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }

  void onChangeBackground() {
    final random = Random();
    emit(state.copyWith(count: random.nextInt(10)));
  }
}
