import 'package:json_annotation/json_annotation.dart';

part 'activation.g.dart';

@JsonSerializable()
class Activation {
  final String secretKey;

  Activation(this.secretKey);

  factory Activation.fromJson(
      Map<String, dynamic> json,
      ) => _$ActivationFromJson(json);
}