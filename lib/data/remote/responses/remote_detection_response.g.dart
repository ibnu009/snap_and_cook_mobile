// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_detection_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteDetectionResponse _$RemoteDetectionResponseFromJson(
        Map<String, dynamic> json) =>
    RemoteDetectionResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => RemoteDetection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RemoteDetectionResponseToJson(
        RemoteDetectionResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
