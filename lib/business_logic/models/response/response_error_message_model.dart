import 'package:bloomdeliveyapp/business_logic/models/response/response_error_messages_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_error_message_model.g.dart';

@JsonSerializable()
class ResponseErrorMeessageModel {
  List<ResponseErrorMeessagesModel>? messages;
  ResponseErrorMeessageModel({
    this.messages,
  });
  factory ResponseErrorMeessageModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseErrorMeessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseErrorMeessageModelToJson(this);
}
