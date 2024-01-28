import 'package:bloomdeliveyapp/business_logic/models/response/response_error_messages_model.dart';
import 'package:bloomdeliveyapp/business_logic/models/response/response_model.dart';
import 'package:bloomdeliveyapp/services/login/login_service_strapi.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:flutter/foundation.dart';

class LoginScreenViewModel extends ChangeNotifier {
  bool isLoggedIn = false;
  bool saving = false;
  final LoginServiceStrapi _loginService = serviceLocator<LoginServiceStrapi>();

  List<ResponseErrorMeessagesModel> message = [];
  ResponseModel response = ResponseModel();
  String errorMessage = '';

  void login(String identifier, String password) async {
    saving = true;
    notifyListeners();
    await _loginService.login(identifier, password).then((value) {
      isLoggedIn = true;
      saving = false;
      notifyListeners();
    });
  }

  getFirstMessage() {
    if (message.isNotEmpty) {
      if (message[0].message!.isNotEmpty) {
        return message[0].message;
      }
    }
    return errorMessage;
  }
}
