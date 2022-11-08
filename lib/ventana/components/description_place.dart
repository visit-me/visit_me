import 'package:flutter/material.dart';

class DescriptionPlace extends StatelessWidget {
  const DescriptionPlace({super.key});

  @override
  Widget build(BuildContext context) {
    final description = Container(
      margin: const EdgeInsets.only(
        top: 20.0,
        right: 20.0,
        left: 20.0
      ),
      child: const Text('La Ventana al mundo es un monumento público ubicado en Barranquilla, Colombia. Fue construido a finales de 2018 para coincidir con los XXIII Juegos Centroamericanos y del Caribe de los cuales la ciudad fue anfitriona. \n \nLa obra es autoría de la arquitecta barranquillera Diana Escorcia Borelly, la construcción se dio por iniciativa de la compañía Tecnoglass S.A. en colaboración con otras compañías como Alutions by Tecnoglass, Aconstruir, Kuraray-Trosifol, Argos, M&P Distribuciones Valledupar (JLQG), GCC, Dow, Alloy, Alutrafic Led, Escenarios Deportivos, Smart Steel, así como la Alcaldía Distrital de Barranquilla.',
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.justify,
      ),
    );

    final title = Align(
      //alignment: Alignment.centerLeft,
      child: Container(
            margin: const EdgeInsets.only(
              top: 335.0,
              left: 20.0,
              right: 20.0
            ),
            child: const Text('La Ventana al Mundo',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w900
            ),
            textAlign: TextAlign.left,
            ),
          ),
    );

    final city = Align(
      alignment: Alignment.centerLeft,
      child: Container(
            margin: const EdgeInsets.only(
              top: 20.0,
              left: 20.0,
              right: 20.0
            ),
            child: const Text('Ciudad: Barranquilla',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.left,
            ),
          ),
    );

    final department = Align(
      alignment: Alignment.centerLeft,
      child: Container(
            margin: const EdgeInsets.only(
              //top: 20.0,
              left: 20.0,
              right: 20.0
            ),
            child: const Text('Departamento: Atlántico',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.left,
            ),
          ),
    );

    final temperature = Align(
      alignment: Alignment.centerLeft,
      child: Container(
            margin: const EdgeInsets.only(
              //top: 20.0,
              left: 20.0,
              right: 20.0
            ),
            child: const Text('Temperatura: 32°',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.left,
            ),
          ),
    );

    final allTogether = Column(
      children: [
        title,
        city,
        department,
        temperature,
        description
      ],
    );

    final scrollDescription = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: allTogether,
    );


    return scrollDescription;
  }
}