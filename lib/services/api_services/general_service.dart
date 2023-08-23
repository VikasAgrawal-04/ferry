import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:goa/src/core/utils/constants/api_endpoints.dart';
import 'package:goa/src/core/utils/errors/failures.dart';
import 'package:goa/src/core/utils/helpers/helpers.dart';

class GeneralService {
  final Dio dio;
  GeneralService(this.dio);

  Future<Either<Failure, Map<String, dynamic>>> getAppInfo(String title) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, EndPoints.appInfo,
          queryParams: {"title": title});
      return Right(response!);
    } on ServerFailure catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }
}
