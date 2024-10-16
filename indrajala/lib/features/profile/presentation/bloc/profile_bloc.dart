import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/features/profile/domain/usecases/getprofile_usecase.dart';
import 'package:indrajala/features/profile/presentation/bloc/profile_event.dart';
import 'package:indrajala/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileInfoUsecase getProfileInfoUsecase;

  ProfileBloc({required this.getProfileInfoUsecase}) : super(ProfileInitial()) {
    on<FetchProfileInfo>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await getProfileInfoUsecase.execute(event.token);
        emit(ProfileLoaded(profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
