import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/models/usuarios.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final usuarios = [
    Usuario(
        online: true,
        email: 'sebastian@gmail.com',
        nombre: 'Sebastian',
        uid: '1'),
    Usuario(online: true, email: 'juan@gmail.com', nombre: 'Juan', uid: '2'),
    Usuario(
        online: false, email: 'camilo@gmail.com', nombre: 'Camilo', uid: '3'),
    Usuario(online: true, email: 'lolo@gmail.com', nombre: 'Lolo', uid: '4'),
    Usuario(online: false, email: 'jimmy@gmail.com', nombre: 'Jimmy', uid: '5'),
    Usuario(online: false, email: 'jimmy@gmail.com', nombre: 'Jimmy', uid: '5'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'Mi nombre',
            style: TextStyle(color: Colors.black54),
          )),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black54,
              )),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue[400],
              ),
              // child: Icon(Icons.offline_bolt, color: Colors.red,),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsuarios,
          header: WaterDropHeader(
            complete: Icon(Icons.check, color: Colors.blue[400],),
            waterDropColor: Color(0xFF42A5F5),
          ),
          child: _listViewUsuarios(),
        )
        );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
          separatorBuilder: (_, i) => Divider(),
          itemCount: usuarios.length);
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      onTap: (){
        
      },
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(usuario.nombre.substring(0, 1)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: usuario.online ? Colors.green[300] : Colors.red),
      ),
    );
  }

  void _cargarUsuarios()async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
