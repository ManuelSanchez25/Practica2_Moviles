import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica_dos/contacto/contacto.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacto"),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 8, right: 8, left: 8),
              child: Text(
                'Aplicación para moviles',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
            child: Text(
              'La  funcion principal de la aplicacion es poder guardar imagenes y recordatorios sobre las clases',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Desarrollador',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(2),
            child: Text(
              'Manuel Eduardo Sánchez Valderrama',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                        _contacto(context);
                },
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8, right: 8, left: 8),
                        child: Text(
                          'Contactame ✉ ',
                          style: TextStyle(
                            fontSize: 30,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );

  }
    void _contacto(BuildContext context) {

    Navigator.of(context).push(

        MaterialPageRoute(builder: (context) => Contactame())

    );

  }
}
