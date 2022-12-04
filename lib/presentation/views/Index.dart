import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:getwidget/getwidget.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:quiniela_hn_app/domain/login/LoginProvider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../data/models/Settings.dart';
import '../../domain/home/HomeProvider.dart';
import '../../domain/home/SettingsProvider.dart';

class Index extends ConsumerStatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  ConsumerState<Index> createState() => _IndexState();
}

class _IndexState extends ConsumerState<Index> {
  final formKey = GlobalKey<FormBuilderState>();
  late SimpleFontelicoProgressDialog dialog;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final LoginNotifier loginNotifier = ref.watch(loginProvider);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GFCard(
              boxFit: BoxFit.fitWidth,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 150.0, width: 150.0, child: Image.asset('assets/images/football-ball.png')),
                  const GFTypography(
                    text: 'Inicia Sesion',
                    type: GFTypographyType.typo1,
                  ),
                  const SizedBox(height: 25,),
                  TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: const Text('Correo electronico o nombre usuario'),
                      suffixIcon: const Icon(Glyphicon.envelope),
                      errorText: loginNotifier.usernameOrEmailEmpty ? 'Este campo es requerido' : null
                    ),
                    onChanged: loginNotifier.setUserNameOrEmail,
                  ),
                  const SizedBox(height: 25,),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: const Text('Contrasena'),
                      suffixIcon: const Icon(Glyphicon.key),
                      errorText: loginNotifier.passwordEmpty ? 'Este campo es requerido' : null
                    ),
                    onChanged: loginNotifier.setPassword,
                  ),
                  const SizedBox(height: 10.0,),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'No tienes una cuenta? Creala ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'aqui',
                          style: const TextStyle(color: Colors.blueAccent),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            showBottomSheet(context, ref);
                          }
                        )
                      ],
                    ),
                  ),
                ],
              ),
              buttonBar: GFButtonBar(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  GFButton(
                    onPressed: () {
                      tryToLogin(context, ref);
                    },
                    text: 'Ingresar',
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }

  void showBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: FormBuilder(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset('assets/images/football-team.png'),
                ),
                const SizedBox(height: 10.0,),
                const Text(
                  'Crea tu cuenta',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, color: Colors.black),
                ),
                const SizedBox(height: 10.0,),
                FormBuilderTextField(
                  name: 'name',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Nombre'),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Este campo es requerido'),
                  ]),
                ),
                const SizedBox(height: 25,),
                FormBuilderTextField(
                  name: 'email',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Correo electronico'),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Este campo es requerido'),
                  ]),
                ),
                const SizedBox(height: 25,),
                FormBuilderTextField(
                  name: 'username',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Nombre de usuario'),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Este campo es requerido'),
                  ]),
                ),
                const SizedBox(height: 25,),
                FormBuilderTextField(
                  name: 'password',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Contrasena'),
                  ),
                  obscureText: true,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Este campo es requerido'),
                    FormBuilderValidators.minLength(8, errorText: 'La contrasena debe ser al menos de 8 caracteres')
                  ]),
                ),
                GFButton(
                  onPressed: () {
                    dialog.show(message: 'Creando usuario');
                    try {
                      if (formKey.currentState!.saveAndValidate()) {
                        final LoginNotifier loginNotifier = ref.read(loginProvider);
                        Map<String, dynamic> json = formKey.currentState!.value;
                        loginNotifier.createUser(json);
                        Navigator.pop(context);
                        GFToast.showToast(
                          'Tu usuario fue creado exitosamente',
                          context,
                          toastPosition: GFToastPosition.BOTTOM,
                          backgroundColor: GFColors.DARK,
                          toastBorderRadius: 10.0,
                          trailing: const Icon(
                            Glyphicon.check,
                            color: GFColors.SUCCESS,
                          )
                        );
                      }
                    } catch(err){
                      showDangerToast(context, 'Error al crear tu usuarios');
                    }
                    dialog.hide();
                  },
                  text: 'Crear',
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  void tryToLogin(BuildContext context, WidgetRef ref) async {
    final LoginNotifier loginNotifier = ref.read(loginProvider);
    final settingsNotifier = ref.read(settingProvider.notifier);
    final games = ref.read(gamesProvider.notifier);
    if (loginNotifier.validateFields()) {
      showDangerToast(context, 'Rellenar los campos requeridos');
      return;
    }
    dialog.show(message: 'Iniciando sesion');
    try {
      await loginNotifier.login();
      Settings _settings = await settingsNotifier.loadSettings();
      await games.loadGames(_settings.currentTournamentId!, _settings.currentGameDayId!);
      dialog.hide();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => true);
    } catch(err) {
      dialog.hide();
      showDangerToast(context, 'Error al iniciar sesion');
    }
  }

  void showDangerToast(BuildContext context, String message) {
    GFToast.showToast(
      message,
      context,
      toastPosition: GFToastPosition.TOP,
      backgroundColor: GFColors.DARK,
      toastBorderRadius: 10.0,
      trailing: const Icon(
        Glyphicon.x_circle_fill,
        color: GFColors.DANGER,
      )
    );
  }
}
