import 'package:json_annotation/json_annotation.dart';

part 'detection_model.g.dart';

@JsonSerializable()
class DetectionModel {
  List<int> finalClasses;
  List<List<double>> finalBboxes;
  List<double> finalScores;


  DetectionModel({
    required this.finalClasses,
    required this.finalBboxes,
    required this.finalScores,
  });

  Map<String, dynamic> toJson() => _$DetectionModelToJson(this);

  factory DetectionModel.fromJson(Map<String, dynamic> json) =>
      _$DetectionModelFromJson(json);
}