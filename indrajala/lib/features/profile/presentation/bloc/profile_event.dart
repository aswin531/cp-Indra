abstract class ProfileEvent {}

class FetchProfileInfo extends ProfileEvent {
  final String token;

  FetchProfileInfo(this.token);
}
