// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      json['payment'] as String,
      json['transaction'] as String,
      (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'payment': instance.payment,
      'transaction': instance.transaction,
      'amount': instance.amount,
    };
