import 'package:fpdart/fpdart.dart';
import 'package:hackathon/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
