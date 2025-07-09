import 'package:training_softdreams/data/network/firebase/animal_firebase.dart';
import 'package:training_softdreams/data/network/firebase/data_sources/animal_firebase_data_sources.dart';
import 'package:training_softdreams/data/network/firebase/data_sources/user_firebase_data_sources.dart';
import 'package:training_softdreams/data/network/firebase/user_firebase.dart';
import 'package:training_softdreams/data/repository/animal_repository_impl.dart';
import 'package:training_softdreams/data/repository/user_repository_impl.dart';
import 'package:training_softdreams/domain/repository/animal_repository.dart';
import 'package:training_softdreams/domain/repository/user_repository.dart';
import 'package:training_softdreams/domain/usecases/animal/add_animal_use_case.dart';
import 'package:training_softdreams/domain/usecases/animal/get_animals_use_case.dart';
import 'package:training_softdreams/domain/usecases/user/login_use_case.dart';
import 'package:training_softdreams/domain/usecases/user/sign_up_use_case.dart';

import '../../data/local/database/app_database.dart';
import '../../data/local/preference/app_preferences.dart';
import '../../data/network/apis/download_api.dart';
import '../../data/network/apis/post_api.dart';
import '../../data/network/apis/sync_api.dart';
import '../../data/network/apis/upload_api.dart';
import '../../data/network/client/none_auth_app_server_api_client.dart';
import '../../data/repository/app_settings_repository_impl.dart';
import '../../data/repository/download_repository_impl.dart';
import '../../data/repository/post_repository_impl.dart';
import '../../data/repository/sync_repository_impl.dart';
import '../../data/repository/token_repository_impl.dart';
import '../../data/repository/upload_repository_impl.dart';
import '../../domain/repository/app_settings_repository.dart';
import '../../domain/repository/download_repository.dart';
import '../../domain/repository/post_repository.dart';
import '../../domain/repository/sync_repository.dart';
import '../../domain/repository/token_repository.dart';
import '../../domain/repository/upload_repository.dart';
import '../../domain/usecases/auth/delete_token.dart';
import '../../domain/usecases/auth/get_authorized_user.dart';
import '../../domain/usecases/download/cancel_download.dart';
import '../../domain/usecases/download/download_file.dart';
import '../../domain/usecases/post/get_list_posts.dart';
import '../../domain/usecases/post/get_list_saved_posts.dart';
import '../../domain/usecases/post/remove_saved_post.dart';
import '../../domain/usecases/post/save_post.dart';
import '../../domain/usecases/settings/get_version_data.dart';
import '../../domain/usecases/settings/save_version_data.dart';
import '../../domain/usecases/sync/sync_post_data.dart';
import '../../domain/usecases/upload/upload_file.dart';
import '../locator.dart';

class AppModule {
  AppModule._();

  static void registerModule() {
    _provideApis();
    _provideDataSources();
    _provideRepository();
    _provideUseCases();
  }

  static void _provideApis() {
    locator.registerLazySingleton(
          () => UploadApi(locator<NoneAuthAppServerApiClient>()),
    );
    locator.registerLazySingleton(
          () => PostApi(locator<NoneAuthAppServerApiClient>()),
    );
    locator.registerLazySingleton(
          () => DownloadApi(locator<NoneAuthAppServerApiClient>()),
    );
    locator.registerLazySingleton(
          () => SyncApi(locator<NoneAuthAppServerApiClient>()),
    );
  }

  static void _provideDataSources() {
    locator.registerLazySingleton<AnimalFirebaseDataSources>(
          () => AnimalFirebaseDataSourcesImpl(locator<AnimalFirebase>()),
    );
    locator.registerLazySingleton<UserFirebaseDataSources>(
          () => UserFirebaseDataSourcesImpl(locator<UserFirebase>()),
    );
  }

  static void _provideRepository() {
    locator.registerLazySingleton<TokenRepository>(
          () =>
          TokenRepositoryImpl(
            locator<AppPreferences>(),
          ),
    );
    locator.registerLazySingleton<UploadRepository>(
          () => UploadRepositoryImpl(locator<UploadApi>()),
    );
    locator.registerLazySingleton<DownloadRepository>(
          () =>
          DownloadRepositoryImpl(
            downloadApi: locator<DownloadApi>(),
            preferences: locator<AppPreferences>(),
          ),
    );
    locator.registerLazySingleton<AppSettingsRepository>(
          () =>
          AppSettingsRepositoryImpl(
            locator<AppPreferences>(),
          ),
    );
    locator.registerLazySingleton<SyncRepository>(
          () =>
          SyncRepositoryImpl(
            syncApi: locator<SyncApi>(),
            database: locator<AppDatabase>(),
          ),
    );
    locator.registerLazySingleton<PostRepository>(
          () =>
          PostRepositoryImpl(
            postApi: locator<PostApi>(),
            database: locator<AppDatabase>(),
          ),
    );

    locator.registerLazySingleton<UserRepository>(
          () =>
          UserRepositoryImpl(
            locator<UserFirebase>(),
          ),
    );
    locator.registerLazySingleton<AnimalRepository>(
          () =>
          AnimalRepositoryImpl(
            animalFirebaseDataSources: locator<AnimalFirebaseDataSources>(),
          ),
    );
  }

  static void _provideUseCases() {
    // Auth
    locator.registerLazySingleton(
          () => GetAuthorizedUser(),
    );
    locator.registerLazySingleton(
          () =>
          DeleteToken(
            tokenRepository: locator<TokenRepository>(),
          ),
    );

    // Upload
    locator.registerLazySingleton(
          () => UploadFile(locator<UploadRepository>()),
    );

    // Download
    locator.registerLazySingleton(
          () => DownloadFile(locator<DownloadRepository>()),
    );
    locator.registerLazySingleton(
          () => CancelDownload(locator<DownloadRepository>()),
    );

    // Settings
    locator.registerLazySingleton(
          () => GetVersionData(locator<AppSettingsRepository>()),
    );
    locator.registerLazySingleton(
          () => SaveVersionData(locator<AppSettingsRepository>()),
    );

    // Sync
    locator.registerLazySingleton(
          () =>
          SyncPostData(
            syncRepository: locator<SyncRepository>(),
          ),
    );

    // Post
    locator.registerLazySingleton(
          () => GetListPosts(locator<PostRepository>()),
    );
    locator.registerLazySingleton(
          () => GetListSavedPosts(locator<PostRepository>()),
    );
    locator.registerLazySingleton(
          () => SavePost(locator<PostRepository>()),
    );
    locator.registerLazySingleton(
          () => RemoveSavedPost(locator<PostRepository>()),
    );

    // User
    locator.registerLazySingleton(
          () => LoginUseCase(locator<UserRepository>()),
    );
    locator.registerLazySingleton(
          () => SignUpUseCase(locator<UserRepository>()),
    );

    // Animal
    locator.registerLazySingleton(
          () => GetAnimalsUseCase(locator<AnimalRepository>()),
    );
    locator.registerLazySingleton(
          () => AddAnimalUseCase(locator<AnimalRepository>()),
    );
  }
}
