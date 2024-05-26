import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:getwidget/getwidget.dart';
import 'package:glyphicon/glyphicon.dart';

class LoginForm extends StatefulWidget {
  final Function(String, String) onLogin;
  const LoginForm({super.key, required this.onLogin});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Inicia sesión',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          FormBuilderTextField(
            name: 'email',
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Glyphicon.envelope,
                  size: 15,
                )),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: 'Este campo es requerido'),
              FormBuilderValidators.email(
                  errorText: 'Este no es un correo válido'),
            ]),
          ),
          const SizedBox(height: 10),
          FormBuilderTextField(
            name: 'password',
            decoration: InputDecoration(
                labelText: 'Contraseña',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(
                  Glyphicon.lock,
                  size: 15,
                ),
                suffixIcon: GFIconButton(
                    type: GFButtonType.transparent,
                    size: 10,
                    icon: showPassword
                        ? Icon(Glyphicon.eye)
                        : Icon(Glyphicon.eye_slash),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    })),
            obscureText: !showPassword,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: 'Este campo es requerido'),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          GFButton(
            type: GFButtonType.solid,
            elevation: 0,
            focusColor: Colors.white,
            onPressed: () {
              if (_formKey.currentState!.saveAndValidate()) {
                Map<String, dynamic> values = _formKey.currentState!.value;
                widget.onLogin(values['email'], values['password']);
              }
            },
            text: 'Iniciar',
          )
        ],
      ),
    );
  }
}
