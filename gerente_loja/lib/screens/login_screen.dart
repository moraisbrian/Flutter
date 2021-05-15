import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/login_bloc.dart';
import 'package:gerente_loja/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.store_mall_directory,
                    color: Colors.pinkAccent,
                    size: 160,
                  ),
                  InputField(
                    icon: Icons.person_outline,
                    hint: 'Usuário',
                    stream: _loginBloc.outEmail,
                    onChanged: _loginBloc.changeEmail,
                  ),
                  InputField(
                    icon: Icons.lock_outline,
                    hint: 'Senha',
                    obscure: true,
                    stream: _loginBloc.outPassword,
                    onChanged: _loginBloc.changePasword,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  StreamBuilder<bool>(
                    stream: _loginBloc.outSubmitValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed:
                              snapshot.hasData ? _loginBloc.submit : null,
                          child: Text('Entrar'),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.pinkAccent.withAlpha(140);
                                } else {
                                  return Colors.pinkAccent;
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
