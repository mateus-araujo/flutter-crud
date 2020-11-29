import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/components/user_tile.dart';
import 'package:flutter_crud/get_it.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> with AfterLayoutMixin {
  final users = getIt<Users>();
  bool _isLoading = false;

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    await users.setAll();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});

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
      body: _isLoading
          ? Center(
              heightFactor: 5,
              child: CircularProgressIndicator(),
            )
          : users.count == 0
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
                          content: Text(
                              'Tem certeza que deseja excluir esse usuário?'),
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
