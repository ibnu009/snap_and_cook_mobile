// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetectionModel _$DetectionModelFromJson(Map<String, dynamic> json) =>
    DetectionModel(
      finalClasses: (json['finalClasses'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      finalBboxes: (json['finalBboxes'] as List<dynamic>)
          .map((e) =>
              (e as List<dynamic>).map((e) => (e as num).toDouble()).toList())
          .toList(),
      finalScores: (json['finalScores'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$DetectionModelToJson(DetectionModel instance) =>
    <String, dynamic>{
      'finalClasses': instance.finalClasses,
      'finalBboxes': instance.finalBboxes,
      'finalScores': instance.finalScores,
    };
