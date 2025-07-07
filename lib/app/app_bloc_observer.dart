import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

import '../utils/logging.dart';

class AppBlocObserver extends BlocObserver {
  final Logger _logger = Logging.createLogger('BlocObserver');

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _logger.info(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _logger.severe(error);
  }
}
