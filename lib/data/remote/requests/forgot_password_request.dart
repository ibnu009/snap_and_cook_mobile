
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request.g.dart';

@JsonSerializable()
class ForgotPasswordRequest {
  String phone;
  String key;

  ForgotPasswordRequest({
    required this.phone,
    required this.key,
  });

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);
}
