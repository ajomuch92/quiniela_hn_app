import 'package:flutter/material.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:quiniela_hn_app/services/AuthService.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:toastification/toastification.dart';

class LoginController {
  Signal activeTab = Signal(0);
  SimpleFontelicoProgressDialog? dialog;

  setActiveTab(int index) {
    activeTab.value = index;
  }

  Future<bool> login(
      String email, String password, BuildContext context) async {
    dialog ??= SimpleFontelicoProgressDialog(context: context);
    dialog!.show(
        message: 'Iniciando...', type: SimpleFontelicoProgressDialogType.notch);
    try {
      await tryToLogin(email, password);
      return true;
    } catch (e) {
      toastification.show(
          context: context,
          title: Text('Hubo un error al iniciar sesión'),
          autoCloseDuration: const Duration(seconds: 5),
          type: ToastificationType.error);
      return false;
    } finally {
      dialog!.hide();
    }
  }
}
