import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../core/network/api_cliente.dart';
import '../core/network/network_imf.dart';
import '../features/data/datasource/article_data_source.dart';
import '../features/data/repository/article_repository_imp.dart';
import '../features/domain/repositorie/article_repository.dart';
import '../features/domain/usecase/get_article.dart';
import '../features/presentation/blocs/article/get_article_bloc.dart';
import '../features/presentation/blocs/test/test_bloc.dart';

final sl = GetIt.instance; // Service Locator

Future<void> initializeDependencies() async {
  // ============== CORE ==============

  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity()); // 👈 AGREGA ESTO

  // Network
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // ============== FEATURES ==============

  // Scroll Feature
  _initAuth();
}

void _initAuth() {
  // Datasources
  sl.registerLazySingleton<ArticleRemoteDataSource>(
    () => ArticleRemoteDataSourceImpl(apiClient: sl()),
  );

  // Repository
  sl.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetArticlesUseCase(sl()));

  // BLoC
  sl.registerFactory(() => ArticleBloc(getArticlesUseCase: sl()));
  sl.registerFactory(() => TesteoBloc());

  // BLoC
  // sl.registerFactory(
  //       () => AuthBloc(
  //     loginUseCase: sl(),
  //     logoutUseCase: sl(),
  //   ),
  // );
}
