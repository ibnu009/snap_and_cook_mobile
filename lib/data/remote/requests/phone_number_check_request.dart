import 'package:json_annotation/json_annotation.dart';
part 'phone_number_check_request.g.dart';

@JsonSerializable()
class PhoneNumberCheckRequest {
  String phone;

  PhoneNumberCheckRequest({
    required this.phone,
  });

  Map<String, dynamic> toJson() => _$PhoneNumberCheckRequestToJson(this);

  factory PhoneNumberCheckRequest.fromJson(Map<String, dynamic> json) =>
      _$PhoneNumberCheckRequestFromJson(json);
}
