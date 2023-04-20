import 'package:asuka/asuka.dart';

class Messages {
  Messages._();
  static alert(String mensage) => AsukaSnackbar.alert(mensage).show();
  static info(String mensage) => AsukaSnackbar.info(mensage).show();
  static sucess(String mensage) => AsukaSnackbar.success(mensage).show();
}
