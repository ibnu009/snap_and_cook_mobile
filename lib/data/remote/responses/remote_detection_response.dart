import 'package:json_annotation/json_annotation.dart';
import 'package:snap_and_cook_mobile/data/remote/models/remote_detection_model.dart';

part 'remote_detection_response.g.dart';

@JsonSerializable()
class RemoteDetectionResponse {
  String? message;
  List<RemoteDetection>? data;

  RemoteDetectionResponse({
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$RemoteDetectionResponseToJson(this);

  factory RemoteDetectionResponse.fromJson(Map<String, dynamic> json) =>
      _$RemoteDetectionResponseFromJson(json);
}