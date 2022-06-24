import 'dart:async';

import 'package:dartz/dartz.dart';
import '../core.dart';

abstract class Repository {
  Future<Either<Failure, T>> makeRequest<T>(
    Future<T> request, {
    Duration? duration,
    Future<T> Function()? onTimeOut,
  }) async {
    try {
      final T response = await request.timeout(
          duration ?? const Duration(seconds: 30), onTimeout: () async {
        if (onTimeOut != null) {
          return onTimeOut();
        }
        throw TimeoutException(null, duration);
      });
      return right(response);
    } on ServerException catch (exception) {
      return left(Failure.server(
          message: exception.message ?? 'Something went wrong technically'));
    } on TimeoutException catch (_) {
      return left(const Failure.timeout());
    } on AppException catch (exception) {
      return left(Failure.client(
          message: exception.message ?? 'Something went wrong technically'));
    } catch (error, stackTrace) {
      AppLog.e(error.toString(), stackTrace);
      return left(
        const Failure.generic(message: 'Something went wrong technically.'),
      );
    }
  }

  Future<Either<Failure, T>> makeLocalRequest<T>(
      Future<T?> Function() request) async {
    try {
      final T? response = await request();
      if (response != null) {
        return right(response);
      } else {
        throw CacheException('Couldn\'t find cached data.');
      }
    } on CacheException catch (exception) {
      return left(
        Failure.server(
          message: exception.message ?? 'Unable to load cache data.',
        ),
      );
    } catch (error, stackTrace) {
      AppLog.e(
        error.toString(),
        stackTrace,
      );
      return left(
        const Failure.generic(message: 'Something went wrong locally.'),
      );
    }
  }
}
