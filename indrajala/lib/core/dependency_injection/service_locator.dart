import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:indrajala/features/auth/bloc/authbloc/auth_bloc.dart';
import 'package:indrajala/features/auth/bloc/visibilitybloc/visibility_bloc.dart';
import 'package:indrajala/features/auth/data/datasources/authlocal_datasource.dart';
import 'package:indrajala/features/auth/data/datasources/authremote_datasource.dart';
import 'package:indrajala/features/auth/data/repositories/auth_repository.dart';
import 'package:indrajala/features/auth/domain/repository/auth_repository.dart';
import 'package:indrajala/features/auth/domain/usecases/gettoken_usecase.dart';
import 'package:indrajala/features/auth/domain/usecases/login_usecases.dart';
import 'package:indrajala/features/auth/domain/usecases/logout_usecase.dart';
import 'package:indrajala/features/auth/domain/usecases/signup_usecase.dart';
import 'package:indrajala/features/auth/domain/usecases/tokenexpiry_usecase.dart';
import 'package:indrajala/features/details/bloc/moviebloc/moviedetail_bloc.dart';
import 'package:indrajala/features/details/data/datasource/moviedetailremote_datasource.dart';
import 'package:indrajala/features/details/data/repositories/moviedetail_repository.dart';
import 'package:indrajala/features/details/domain/repository/moviedetail_repo.dart';
import 'package:indrajala/features/details/domain/usecases/checksubscription_usecase.dart';
import 'package:indrajala/features/details/domain/usecases/getmoviedetail_usecase.dart';
import 'package:indrajala/features/details/domain/usecases/playmovie.dart';
import 'package:indrajala/features/details/domain/usecases/playtrailer.dart';
import 'package:indrajala/features/home/bloc/indicator/indicator_bloc.dart';
import 'package:indrajala/features/home/bloc/movie/movie_bloc.dart';
import 'package:indrajala/features/home/data/datasource/movieremote_datasource.dart';
import 'package:indrajala/features/home/data/repository/movie_repository.dart';
import 'package:indrajala/features/home/domain/repository/movie_repository.dart';
import 'package:indrajala/features/home/domain/usecases/carousel_usecases.dart';
import 'package:indrajala/features/home/domain/usecases/launchurl_usecase.dart';
import 'package:indrajala/features/home/domain/usecases/topfivemovie_usecases.dart';
import 'package:indrajala/features/home/domain/usecases/toptrendingmovies.dart.dart';
import 'package:indrajala/features/home/domain/usecases/upcomingmovies_usecase.dart';
import 'package:indrajala/features/profile/data/datasource/profile_datasource.dart';
import 'package:indrajala/features/profile/data/repository/profilerepoimple.dart';
import 'package:indrajala/features/profile/domain/repository/profilerepository.dart';
import 'package:indrajala/features/profile/domain/usecases/getprofile_usecase.dart';
import 'package:indrajala/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:indrajala/features/splash/bloc/splash_bloc.dart';
import 'package:indrajala/features/subscription/bloc/paymentbloc/payment_bloc.dart';
import 'package:indrajala/features/subscription/bloc/subscriptionbloc/subscription_bloc.dart';
import 'package:indrajala/features/subscription/data/datasource/payment_datasource.dart';
import 'package:indrajala/features/subscription/data/repository/payment_repo_imple.dart';
import 'package:indrajala/features/subscription/data/repository/subscriptionplan_repoimpl.dart';
import 'package:indrajala/features/subscription/domain/repository/payment_repository.dart';
import 'package:indrajala/features/subscription/domain/repository/subscription_plan_repository.dart';
import 'package:indrajala/features/subscription/domain/usecases/createorder_usecase.dart';
import 'package:indrajala/features/subscription/domain/usecases/verifypayment_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Authentication--------------------------------------------------------------

  sl.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());

  sl.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasource()); //AuthLocalDatasource
  sl.registerLazySingleton<AuthLocalDatasource>(
      () => AuthLocalDatasource()); //AuthLocalDatasource

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => CheckTokenExpirationUseCase(sl()));
  sl.registerLazySingleton(() => GetTokenUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  sl.registerFactory(() => AuthBloc(
        sl<LoginUseCase>(),
        sl<SignUpUseCase>(),
        sl<CheckTokenExpirationUseCase>(),
        sl<GetTokenUseCase>(),
        sl<LogoutUseCase>(),
      ));

  //Visibility--------------------------------------------------------------
  sl.registerFactory(() => PasswordVisibilityBloc());

  //Splash--------------------------------------------------------------
  sl.registerFactory(() => SplashBloc(sl()));

  //Movie -Home --------------------------------------------------------------
  sl.registerLazySingleton<http.Client>(() => http.Client());

  sl.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSource());

  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(sl()));

  sl.registerLazySingleton(() => GetTopTrendingMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetTopFiveMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetUpcomingMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetCarouselImagesUseCase(sl()));

  sl.registerLazySingleton(() => LaunchUrlUseCase());

  sl.registerFactory(() => MovieBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => IndicatorBloc());

  //Movie Detail ----------------------------------------------------------------------

  sl.registerLazySingleton(() => MoviedetailremoteDatasource());

  sl.registerLazySingleton<MovieDetailRepository>(
      () => MovieDetailRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton(() => GetMovieDetailUsecase(sl()));
  sl.registerLazySingleton(() => PlayTrailerUsecase(sl()));
  sl.registerLazySingleton(() => CheckSubscriptionStatusUseCase(sl()));
  sl.registerLazySingleton(() => GetMovieStreamUrlUseCase(sl()));

  sl.registerFactory(() => MovieDetailBloc(
      getMovieDetailUsecase: sl(),
      playTrailerUsecase: sl(),
      checkSubscriptionStatusUseCase: sl(),
      getTokenUseCase: sl(),
      getMovieStreamUrlUseCase: sl()));

  //Profile----------------------------------------------------------------

  sl.registerLazySingleton(() => ProfileRemoteDataSource());

  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton(() => GetProfileInfoUsecase(sl()));

  sl.registerFactory(() => ProfileBloc(getProfileInfoUsecase: sl()));

  //Payment ----------------------------------------------------------------

  sl.registerLazySingleton(() => PaymentRemoteDataSource());

  sl.registerLazySingleton<PaymentRepository>(
      () => PaymentRepositoryImpl(sl()));

  // sl.registerLazySingleton(() => PaymentVerificationSuccess());
  sl.registerLazySingleton(
      () => CreateOrderUseCase(sl())); //VerifyPaymentUseCase
  sl.registerLazySingleton(() => VerifyPaymentUseCase(sl()));

  sl.registerFactory(
      () => PaymentBloc(createOrderUseCase: sl(), verifyPaymentUseCase: sl()));

  //Subscription----------------------------------------------------------------

  sl.registerFactory(() => SubscriptionBloc(sl()));

  sl.registerLazySingleton<SubscriptionRepository>(
      () => SubscriptionRepositoryImpl());
}
