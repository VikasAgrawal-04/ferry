import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:goa/src/core/errors/exception.dart';
import 'package:goa/src/core/utils/constants/api_endpoints.dart';
import 'package:goa/src/core/utils/helpers/helpers.dart';

import '../../src/core/errors/failures.dart';
import '../../src/core/utils/constants/keys.dart';
import '../../src/models/payment/payment_model.dart';

class PaytmService {
  final Dio dio;
  PaytmService({required this.dio});

  Future<Either<Failure, PaytmCheckSum>> generateChecksum(
      {required int passId, required int amount}) async {
    try {
      final userId = Helpers.getString(key: Keys.userId);
      final deviceId = Helpers.getString(key: Keys.deviceId);
      final response = await Helpers.sendRequest(
          dio, RequestType.post, EndPoints.createChecksum,
          data: {
            "userid": userId,
            "currentdeviceid": deviceId,
            'passid': passId,
            'amount': amount
          });
      return Right(PaytmCheckSum.fromJson(response!));
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }
}
