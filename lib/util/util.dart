import 'package:json_annotation/json_annotation.dart';

class GenericConverter<T> implements JsonConverter<T?, Object?> {
  const GenericConverter();
  @override
  T? fromJson(Object? json) => throw UnimplementedError();
  @override
  Object? toJson(T? object) => throw UnimplementedError();
}