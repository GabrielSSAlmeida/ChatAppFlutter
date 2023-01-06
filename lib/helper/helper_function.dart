import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  //Keys
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";

  //Salvando data do SharedPreferences
  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSP(String userName) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmailSP(String userEmail) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setString(userEmailKey, userEmail);
  }

  //get data do SP
  static Future<bool?> getUserLoggedInStatus() async {
    //Intancia um SP
    SharedPreferences sp = await SharedPreferences.getInstance();
    //Retornar o valor de uma chave LOGGEDINKEY
    return sp.getBool(userLoggedInKey);
    //Retorna null se nn existir
  }
}
