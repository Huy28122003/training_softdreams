import 'package:training_softdreams/data/network/firebase/animal_firebase.dart';

import '../../data/local/preference/app_preferences.dart';
import '../../data/network/client/none_auth_app_server_api_client.dart';
import '../../data/network/firebase/user_firebase.dart';
import '../../data/network/interceptors/access_token_interceptor.dart';
import '../locator.dart';

class NetworkModule {
  NetworkModule._();

  static void registerModule() {
    _provideInterceptors();
    _provideRestClient();
    _provideFirebase();
  }

  static void _provideInterceptors() {
    locator.registerLazySingleton(
      () => AccessTokenInterceptor(locator<AppPreferences>()),
    );
  }

  static void _provideRestClient() {
    locator.registerLazySingleton(() => NoneAuthAppServerApiClient());
  }

  static void _provideFirebase() {
    locator.registerLazySingleton(() => UserFirebase());
    locator.registerLazySingleton(() => AnimalFirebase());
  }
}
