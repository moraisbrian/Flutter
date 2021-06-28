import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/product_bloc.dart';
import 'package:gerente_loja/widgets/images_widget.dart';

class ProductScreen extends StatefulWidget {
  final String categoryId;
  final DocumentSnapshot product;

  ProductScreen({@required this.categoryId, this.product});

  @override
  _ProductScreenState createState() => _ProductScreenState(categoryId, product);
}

class _ProductScreenState extends State<ProductScreen> {
  _ProductScreenState(String categoryId, DocumentSnapshot product)
      : _productBloc = ProductBloc(categoryId: categoryId, product: product);

  final ProductBloc _productBloc;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _fieldStyle = TextStyle(color: Colors.white, fontSize: 16);

    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
        title: Text('Criar Produto'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.remove),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: StreamBuilder<Map>(
            stream: _productBloc.outData,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              return ListView(
                padding: EdgeInsets.all(16),
                children: [
                  Text(
                    'Imagens',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  ImagesWidget(
                    context: context,
                    initialValue: snapshot.data['images'],
                    onSaved: (list) {},
                    validator: (list) {},
                  ),
                  TextFormField(
                    initialValue: snapshot.data['title'],
                    style: _fieldStyle,
                    decoration: _buildDecoration('Título'),
                    onSaved: (text) {},
                    validator: (text) {},
                  ),
                  TextFormField(
                    initialValue: snapshot.data['description'],
                    style: _fieldStyle,
                    maxLines: 6,
                    decoration: _buildDecoration('Descrição'),
                    onSaved: (text) {},
                    validator: (text) {},
                  ),
                  TextFormField(
                    initialValue: snapshot.data['price']?.toStringAsFixed(2),
                    style: _fieldStyle,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: _buildDecoration('Preço'),
                    onSaved: (text) {},
                    validator: (text) {},
                  ),
                ],
              );
            }),
      ),
    );
  }
}
