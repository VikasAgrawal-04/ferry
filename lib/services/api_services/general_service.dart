import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:goa/src/core/utils/constants/api_endpoints.dart';
import 'package:goa/src/core/errors/failures.dart';
import 'package:goa/src/core/utils/helpers/helpers.dart';

import '../../src/models/info/app_info_model.dart';
import '../../src/models/info/contact_info.dart';

class GeneralService {
  final Dio dio;
  GeneralService(this.dio);

  Future<Either<Failure, AppInfoModel>> getAppInfo() async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, EndPoints.appInfo,
          queryParams: {});
      return Right(AppInfoModel.fromJson(response!));
    } on ServerFailure catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  Future<Either<Failure, ContactInformation>> getContactInfo() async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, EndPoints.contactInfo,
          queryParams: {});
      return Right(ContactInformation.fromJson(response!));
    } on ServerFailure catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }
}
