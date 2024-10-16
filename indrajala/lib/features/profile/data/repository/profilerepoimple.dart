import 'package:indrajala/features/profile/data/datasource/profile_datasource.dart';
import 'package:indrajala/features/profile/data/model/userprofile_model.dart';
import 'package:indrajala/features/profile/domain/repository/profilerepository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ProfileModel> getProfileInfo(String token) async {
    return await remoteDataSource.getProfileInfo(token);
  }
}