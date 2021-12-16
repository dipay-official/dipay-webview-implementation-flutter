import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment {
  String payment;
  String transaction;
  double amount;

  Payment(this.payment, this.transaction, this.amount);

  factory Payment.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PaymentFromJson(json);
}
