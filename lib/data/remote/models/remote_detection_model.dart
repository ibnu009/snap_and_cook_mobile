import 'package:json_annotation/json_annotation.dart';

part 'remote_detection_model.g.dart';

@JsonSerializable()
class RemoteDetection {
  @JsonKey(name: 'class')
  int datumClass;
  double confidence;
  double height;
  String name;
  double width;
  double xcenter;
  double ycenter;

  RemoteDetection({
    required this.datumClass,
    required this.confidence,
    required this.height,
    required this.name,
    required this.width,
    required this.xcenter,
    required this.ycenter,
  });


  Map<String, dynamic> toJson() => _$RemoteDetectionToJson(this);

  factory RemoteDetection.fromJson(Map<String, dynamic> json) =>
      _$RemoteDetectionFromJson(json);
}