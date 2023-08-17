import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:goa/src/core/utils/errors/failures.dart';
import 'package:goa/src/models/routes/routes_info_model.dart';

class RouteService {
  final Dio dio;
  RouteService({required this.dio});

  Future<Either<Failure, RouteInfo>> fetchRoutes() async {
    try {} on ServerFailure catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }
}
