import 'package:flutter/material.dart';
import 'package:flutter_crud/components/user_tile.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.USER_FORM,
              );
            },
          )
        ],
      ),
      body: users.count == 0
          ? Center(
              heightFactor: 5,
              child: Text('Sem usuários na lista, \nclique para adicionar'),
            )
          : ListView.builder(
              itemCount: users.count,
              itemBuilder: (context, index) => UserTile(
                user: users.byIndex(index),
                onRemove: () async {
                  final confirmed = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Excluir Usuário'),
                      content:
                          Text('Tem certeza que deseja excluir esse usuário?'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                        FlatButton(
                          child: Text('Sim'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    ),
                  );

                  if (confirmed) {
                    users.remove(users.byIndex(index));
                  }
                },
              ),
            ),
    );
  }
}
