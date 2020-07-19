import 'dart:convert';
import 'package:http/http.dart' as http;

var LoginValue;

//loginAPI Calling
Future loginAPI(String email, String password) async {
  try {
    Map<String, String> aheaders = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    final msg = jsonEncode({
      "grant_type": "Pass",
      "User": email,
      "Pass": password,
    });
    http.Response response = await http
        .post("http://ozonediam.com/MobAppService.svc/Login",
            headers: aheaders, body: msg)
        .then((value) {
      return value;
    });
    LoginValue = json.decode(response.body);
    print('login done:' + LoginValue.toString());
    return LoginValue;
  } catch (error) {
    print(error);
  }
}

//Json Varible
//LoginUser user = LoginUser.fromJson(LoginValue);

//class for get value from json
class LoginUser {
  String msgs,
      emailID,
      token,
      name,
      firstname,
      partycode,
      status,
      userID,
      userTYPE,
      buy;
  LoginUser(
      {this.msgs,
      this.emailID,
      this.token,
      this.name,
      this.firstname,
      this.partycode,
      this.status,
      this.userID,
      this.userTYPE,
      this.buy});
  factory LoginUser.fromJson(Map<String, dynamic> parsedJson) {
    Map json = parsedJson['LoginResult'];
    return LoginUser(
        buy: json['BUY_ALLOW'].toString(),
        msgs: json['MSG'],
        emailID: json['EMAIL_ID'],
        token: json['TOKEN'].toString(),
        name: json['DISPLAY_NAME'],
        firstname: json['FIRST_NAME'],
        partycode: json['PARTY_CODE'],
        status: json['STATUS'].toString(),
        userID: json['USER_ID'].toString(),
        userTYPE: json['USER_TYPE']);
  }
}
