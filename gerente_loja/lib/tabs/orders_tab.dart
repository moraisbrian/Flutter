import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/orders_bloc.dart';
import 'package:gerente_loja/widgets/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _ordersBloc = BlocProvider.getBloc<OrdersBloc>();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: StreamBuilder<List>(
        stream: _ordersBloc.outOrders,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
              ),
            );
          } else if (snapshot.data.length == 0) {
            return Center(
              child: Text(
                'Nenhum pedido encontrado',
                style: TextStyle(color: Colors.pinkAccent),
              ),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return OrderTile(order: snapshot.data[index]);
              },
              itemCount: snapshot.data.length,
            );
          }
        },
      ),
    );
  }
}
