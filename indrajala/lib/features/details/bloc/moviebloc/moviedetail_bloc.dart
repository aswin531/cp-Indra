import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/features/auth/domain/usecases/gettoken_usecase.dart';
import 'package:indrajala/features/details/bloc/moviebloc/moviedetail_event.dart';
import 'package:indrajala/features/details/bloc/moviebloc/moviedetail_state.dart';
import 'package:indrajala/features/details/domain/usecases/checksubscription_usecase.dart';
import 'package:indrajala/features/details/domain/usecases/getmoviedetail_usecase.dart';
import 'package:indrajala/features/details/domain/usecases/playmovie.dart';
import 'package:indrajala/features/details/domain/usecases/playtrailer.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetailUsecase getMovieDetailUsecase;
  final PlayTrailerUsecase playTrailerUsecase;
  final CheckSubscriptionStatusUseCase checkSubscriptionStatusUseCase;
  final GetMovieStreamUrlUseCase getMovieStreamUrlUseCase;
  final GetTokenUseCase getTokenUseCase;


  MovieDetailBloc(
      {required this.getMovieDetailUsecase,
      required this.playTrailerUsecase,
      required this.checkSubscriptionStatusUseCase,
      required this.getMovieStreamUrlUseCase,
      required this.getTokenUseCase})
      : super(MovieDetailInitial()) {
    on<FetchMovieDetail>(_onFetchMovieDetail);
    on<PlayMovieTrailer>(_onPlayMovieTrailer);
    on<CheckSubscriptionStatus>(_onCheckSubscriptionStatus);
    on<GetMovieStreamUrl>(_onGetMovieStreamUrl);
  }

  void _onFetchMovieDetail(
      FetchMovieDetail event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoading());
    try {
      final movie = await getMovieDetailUsecase(event.url);
      emit(MovieDetailLoaded(movie: movie));
    } catch (error) {
        //print('Error fetching movie details: $error');

      emit(MovieDetailError(message: 'Failed to load movie details'));
    }
  }

  void _onPlayMovieTrailer(
      PlayMovieTrailer event, Emitter<MovieDetailState> emit) async {
    emit(TrailerLoading());
    try {
      final trailerUrl = await playTrailerUsecase(event.url);
      emit(TrailerLoaded(trailerUrl: trailerUrl));
    } catch (error) {
      emit(TrailerError(message: 'Failed to load trailer'));
    }
  }

  // Future<void> _onCheckSubscriptionStatus(
  //     CheckSubscriptionStatus event, Emitter<MovieDetailState> emit) async {
  //   try {
  //     final isSubscribed =
  //         await checkSubscriptionStatusUseCase.execute(event.token);
  //     emit(SubscriptionStatusChecked(isSubscribed: isSubscribed));
  //   } catch (e) {
  //     emit(MovieDetailError(message: e.toString()));
  //   }
  // }

  Future<void> _onGetMovieStreamUrl(
      GetMovieStreamUrl event, Emitter<MovieDetailState> emit) async {
    try {
      final streamUrl = await getMovieStreamUrlUseCase.execute(event.url);
      emit(MovieStreamUrlLoaded(streamUrl: streamUrl));
    } catch (e) {
      emit(MovieDetailError(message: e.toString()));
    }
  }


  void _onCheckSubscriptionStatus(
    CheckSubscriptionStatus event, Emitter<MovieDetailState> emit) async {
  try {
    // Retrieve the token first using the GetTokenUseCase
    final token = await getTokenUseCase();  // Assuming you already have getTokenUseCase injected
    if (token != null) {
      // Pass the token to the checkSubscriptionStatusUseCase
      final isSubscribed = await checkSubscriptionStatusUseCase.execute(token);
      emit(SubscriptionStatusChecked(isSubscribed: isSubscribed));
    } else {
      emit(MovieDetailError(message: 'Failed to retrieve token'));
    }
  } catch (e) {
    emit(MovieDetailError(message: e.toString()));
  }
}

}
