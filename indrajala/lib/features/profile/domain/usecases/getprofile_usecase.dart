import 'package:indrajala/features/profile/data/model/userprofile_model.dart';
import 'package:indrajala/features/profile/domain/repository/profilerepository.dart';

class GetProfileInfoUsecase {
  final ProfileRepository repository;

  GetProfileInfoUsecase(this.repository);

  Future<ProfileModel> execute(String token) async {
    return await repository.getProfileInfo(token);
  }
}
