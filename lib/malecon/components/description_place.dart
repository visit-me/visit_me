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
      child: const Text('Malecón ubicado sobre ribera del río Magdalena con hermosos paisajes del río y el Vía Parque Isla Salamanca. Es el espacio ideal para las familias que buscan disfrutar de una experiencia al aire libre y en contacto directo con las riquezas naturales del entorno. Incluye corredor verde, parque para niños, ciclo rutas y una variada oferta gastronómica.',
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
              top: 325.0,
              left: 20.0,
              right: 20.0
            ),
            child: const Text('El Malecón',
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