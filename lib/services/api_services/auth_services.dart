import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:goa/src/core/utils/constants/api_endpoints.dart';
import 'package:goa/src/core/utils/errors/failures.dart';
import 'package:goa/src/core/utils/helpers/helpers.dart';
import 'package:goa/src/models/auth/response/login_response.dart';

import '../../src/models/auth/response/register_response.dart';

class AuthServices {
  final Dio dio;
  AuthServices({required this.dio});

  Future<Either<Failure, LoginResponse>> login(
      {required String number, required String password}) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, EndPoints.login, queryParams: {
        "mobile": number,
        "password": password,
        "usertype": "N"
      });
      return Right(LoginResponse.fromJson(response!));
    } on ServerFailure catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  Future<Either<Failure, RegisterResponse>> register(
      {required String name,
      required String number,
      required String password}) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, EndPoints.createUser, queryParams: {
        "mobile": number,
        "password": password,
        "fullname": name
      });
      return Right(RegisterResponse.fromJson(response!));
    } on ServerFailure catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> verfiyOtp(
      {required String number, required String otp}) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, EndPoints.verifyOtp,
          queryParams: {"mobile": number, "otp": otp, "usertype": "N"});
      return Right(response!);
    } on ServerFailure catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }
}
