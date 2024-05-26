import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:getwidget/getwidget.dart';
import 'package:glyphicon/glyphicon.dart';

class SignUpForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSignUp;
  const SignUpForm({super.key, required this.onSignUp});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool showPassword = false;
  bool showPasswordConfirm = false;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Regístrate',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          FormBuilderTextField(
            name: 'Name',
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Glyphicon.person,
                  size: 15,
                )),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: 'Este campo es requerido'),
            ]),
          ),
          const SizedBox(
            height: 10,
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
              FormBuilderValidators.minLength(8,
                  errorText: 'La contraseña debe ser de más de 8 caracteres')
            ]),
          ),
          const SizedBox(height: 10),
          FormBuilderTextField(
            name: 'passwordConfirm',
            decoration: InputDecoration(
                labelText: 'Repetir Contraseña',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(
                  Glyphicon.lock_fill,
                  size: 15,
                ),
                suffixIcon: GFIconButton(
                    type: GFButtonType.transparent,
                    size: 10,
                    icon: showPasswordConfirm
                        ? Icon(Glyphicon.eye)
                        : Icon(Glyphicon.eye_slash),
                    onPressed: () {
                      setState(() {
                        showPasswordConfirm = !showPasswordConfirm;
                      });
                    })),
            obscureText: !showPasswordConfirm,
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
                widget.onSignUp(values);
              }
            },
            text: 'Registrarme',
          )
        ],
      ),
    );
  }
}
