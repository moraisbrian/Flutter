import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/create/components/images_field.dart';
import 'package:xlo_mobx/stores/create_store.dart';

import 'components/category_field.dart';
import 'components/cep_field.dart';

class CreateScreen extends StatelessWidget {
  final CreateStore createStore = CreateStore();
  @override
  Widget build(BuildContext context) {
    final TextStyle _labelStyle = TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.grey,
      fontSize: 18,
    );

    final _contentPadding = const EdgeInsets.fromLTRB(16, 10, 12, 10);

    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Anúncio'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImagesField(createStore),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: _contentPadding,
                labelText: 'Título *',
                labelStyle: _labelStyle,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: _contentPadding,
                labelText: 'Descrição *',
                labelStyle: _labelStyle,
              ),
              maxLines: null,
            ),
            CategoryField(createStore),
            CepField(),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: _contentPadding,
                labelText: 'Proço *',
                labelStyle: _labelStyle,
                prefixText: 'R\$ ',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                RealInputFormatter(centavos: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
