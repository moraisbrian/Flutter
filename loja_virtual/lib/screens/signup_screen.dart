import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Criar Conta'),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                TextFormField(
                  controller: _nameController,
                  validator: (text) {
                    if (text.isEmpty)
                      return 'Nome Inválido';
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Nome Completo',
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _emailController,
                  validator: (text) {
                    if (text.isEmpty || !text.contains('@'))
                      return 'E-mail inválido';
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _passController,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return 'Senha inválida';
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Senha',
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _addressController,
                  validator: (text) {
                    if (text.isEmpty)
                      return 'Endereço inválido';
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Endereço',
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'address': _addressController.text
                        };

                        model.signUp(
                            userData: userData,
                            pass: _passController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail);
                      }
                    },
                    child: Text(
                      'Criar Conta',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.grey[400];
                          } else {
                            return Theme.of(context).primaryColor;
                          }
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
    ScaffoldMessenger.of(_scaffoldKey.currentContext).showSnackBar(
      SnackBar(
        content: Text('Usuário criado com sucesso!'),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(Duration(seconds: 2)).then(
      (_) => Navigator.of(context).pop(),
    );
  }

  void _onFail() {
    ScaffoldMessenger.of(_scaffoldKey.currentContext).showSnackBar(
      SnackBar(
        content: Text('Falha ao criar usuário!'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(Duration(seconds: 2)).then(
      (_) => Navigator.of(context).pop(),
    );
  }
}
