// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_callback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseCallback<T> _$BaseCallbackFromJson<T>(
  Map json,
  T Function(Object? json) fromJsonT,
) =>
    BaseCallback<T>(
      json['code'] as String?,
      _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$BaseCallbackToJson<T>(
  BaseCallback<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'code': instance.code,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
