import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_request.g.dart';

@JsonSerializable()
class VerifyOtpRequest {
  String phone;
  String otpCode;

  VerifyOtpRequest({
    required this.phone,
    required this.otpCode,
  });

  Map<String, dynamic> toJson() => _$VerifyOtpRequestToJson(this);

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);
}