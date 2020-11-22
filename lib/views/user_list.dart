import 'package:flutter/material.dart';
import 'package:flutter_crud/components/user_tile.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              users.put(
                User(name: 'teste', email: 'teste@email', avatarUrl: ''),
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
              itemBuilder: (context, index) => UserTile(users.byIndex(index)),
            ),
    );
  }
}
