import 'package:json_annotation/json_annotation.dart';

part 'base_callback.g.dart';
@JsonSerializable(genericArgumentFactories: true, anyMap: true, explicitToJson: true)
class BaseCallback<T> {
  T? data;

  String? code;
  BaseCallback(this.code, this.data);
  factory BaseCallback.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) => _$BaseCallbackFromJson(json, fromJsonT);
}
