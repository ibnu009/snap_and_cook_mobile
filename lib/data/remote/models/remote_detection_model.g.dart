// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_detection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteDetection _$RemoteDetectionFromJson(Map<String, dynamic> json) =>
    RemoteDetection(
      datumClass: (json['class'] as num).toInt(),
      confidence: (json['confidence'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      name: json['name'] as String,
      width: (json['width'] as num).toDouble(),
      xcenter: (json['xcenter'] as num).toDouble(),
      ycenter: (json['ycenter'] as num).toDouble(),
    );

Map<String, dynamic> _$RemoteDetectionToJson(RemoteDetection instance) =>
    <String, dynamic>{
      'class': instance.datumClass,
      'confidence': instance.confidence,
      'height': instance.height,
      'name': instance.name,
      'width': instance.width,
      'xcenter': instance.xcenter,
      'ycenter': instance.ycenter,
    };
