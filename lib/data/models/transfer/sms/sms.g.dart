// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SmsImpl _$$SmsImplFromJson(Map<String, dynamic> json) => _$SmsImpl(
      email: json['email'] as String?,
      ttl: (json['ttl'] as num?)?.toInt(),
      content: json['content'] as String?,
    );

Map<String, dynamic> _$$SmsImplToJson(_$SmsImpl instance) => <String, dynamic>{
      'email': instance.email,
      'ttl': instance.ttl,
      'content': instance.content,
    };
