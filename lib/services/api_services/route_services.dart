import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:goa/src/core/errors/failures.dart';
import 'package:goa/src/core/utils/constants/api_endpoints.dart';
import 'package:goa/src/core/utils/constants/keys.dart';
import 'package:goa/src/core/utils/helpers/helpers.dart';
import 'package:goa/src/models/routes/routes_info_model.dart';

import '../../src/models/purchase_history/purchase_history_model.dart';
import '../../src/models/routes/route_passes.dart';
import '../../src/models/your_pass/your_passes_model.dart';

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

  Future<Either<Failure, RoutePasses>> getRoutePasses(
      {required int routeId, required String vehicleType}) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, EndPoints.getPassByRoute,
          queryParams: {"routeid": routeId, "vehicletype": vehicleType});
      return Right(RoutePasses.fromJson(response!));
    } on ServerFailure catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> createPass(
      {required int passId}) async {
    try {
      final userId = Helpers.getString(key: Keys.userId);
      final deviceId = Helpers.getString(key: Keys.deviceId);
      final response = await Helpers.sendRequest(
          dio, RequestType.post, EndPoints.createPass,
          queryParams: {
            "userid": userId,
            "passid": passId,
            "payment_mode": "C",
            "payment_reference": "XYZ123",
            "currentdeviceid": deviceId
          });
      return Right(response!);
    } on ServerFailure catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  Future<Either<Failure, YourPassesModel>> getYourPasses() async {
    try {
      final userId = Helpers.getString(key: Keys.userId);
      final deviceId = Helpers.getString(key: Keys.deviceId);
      final response = await Helpers.sendRequest(
          dio, RequestType.post, EndPoints.currentPass,
          queryParams: {"currentuserid": userId, "currentdeviceid": deviceId});
      return Right(YourPassesModel.fromJson(response!));
    } on ServerFailure catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> transferPass(
      {required String passCode}) async {
    try {
      final userId = Helpers.getString(key: Keys.userId);
      final deviceId = Helpers.getString(key: Keys.deviceId);
      final response = await Helpers.sendRequest(
          dio, RequestType.post, EndPoints.transferPass, queryParams: {
        "passcode": passCode,
        "currentdeviceid": deviceId,
        "currentuserid": userId
      });
      return Right(response!);
    } on ServerFailure catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> checkPaperPass(
      {required String paperPass}) async {
    try {
      final userId = Helpers.getString(key: Keys.userId);
      final deviceId = Helpers.getString(key: Keys.deviceId);
      final response = await Helpers.sendRequest(
          dio, RequestType.post, EndPoints.paperPass, queryParams: {
        'paperpassid': paperPass,
        'userid': userId,
        'currentdeviceid': deviceId
      });
      return Right(response!);
    } on ServerFailure catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> importPass(
      {required String transferCode}) async {
    try {
      final userId = Helpers.getString(key: Keys.userId);
      final deviceId = Helpers.getString(key: Keys.deviceId);
      final response = await Helpers.sendRequest(
          dio, RequestType.post, EndPoints.importPass, queryParams: {
        "transfercode": transferCode,
        "deviceid": deviceId,
        "userid": userId
      });
      return Right(response!);
    } on ServerFailure catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  Future<Either<Failure, PurchaseHistory>> purchaseHistory() async {
    try {
      final userId = Helpers.getString(key: Keys.userId);
      final response = await Helpers.sendRequest(
          dio, RequestType.post, EndPoints.purchaseHistory,
          queryParams: {"userid": userId});
      return Right(PurchaseHistory.fromJson(response!));
    } on ServerFailure catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }
}
