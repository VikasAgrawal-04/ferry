import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:goa/src/core/utils/constants/api_endpoints.dart';
import 'package:goa/src/core/utils/errors/failures.dart';
import 'package:goa/src/core/utils/helpers/helpers.dart';
import 'package:goa/src/models/routes/routes_info_model.dart';

class RouteService {
  final Dio dio;
  RouteService({required this.dio});

  Future<Either<Failure, RouteInfo>> fetchRoutes() async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, EndPoints.getRoutes,
          queryParams: {});
      return Right(RouteInfo.fromJson(response!));
    } on ServerFailure catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }
}
