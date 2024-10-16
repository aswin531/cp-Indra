import 'package:indrajala/features/profile/data/model/userprofile_model.dart';

abstract class ProfileRepository {
  Future<ProfileModel> getProfileInfo(String token);
}