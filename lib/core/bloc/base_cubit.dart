import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<S> extends Cubit<S> {
  BaseCubit(super.initialState);

  @override
  void emit(S state) {
    if (isClosed) return;
    super.emit(state);
  }
}
