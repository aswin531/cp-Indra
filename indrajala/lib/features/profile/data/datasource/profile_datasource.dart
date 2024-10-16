import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:indrajala/core/constants/api_constants.dart';
import 'package:indrajala/core/constants/http_statuscode.dart';
import 'package:indrajala/core/exceptions/api_exceptions.dart';
import 'package:indrajala/features/profile/data/model/userprofile_model.dart';

class ProfileRemoteDataSource {

  ProfileRemoteDataSource();

  Future<ProfileModel> getProfileInfo(String token) async {
    final response = await httpClient.post(
      Uri.parse(ApiConstants.profileInfo),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'token': token}),
    );

    if (response.statusCode == HttpStatusCodes.ok) {
      return ProfileModel.fromJson(json.decode(response.body));
    } else {
      debugPrint(response.statusCode.toString());
      throw ApiException(
          customMessage: 'Failed to load profile', response.statusCode);
    }
  }
}
