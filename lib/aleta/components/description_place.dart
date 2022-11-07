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
      child: const Text('La Ventana de Campeones, diseñada por los arquitectos barranquilleros Miguel Ángel Cure y Pablo Andrés Castellano, y construida por Tecnoglass de la mano de sus empresas aliadas, es una estructura de 33 metros de alto, que marca el camino para el urbanismo en la ciudad al dar vida a un sector olvidado como la Isla de la Loma, que en un futuro se conectará con el renovado malecón. \n \nAsimismo, la rotonda donde se encuentra ubicado ofrece diversas vivencias para los visitantes. “Pueden aprender del Junior. Es un museo al aire libre, ves las huellas de los jugadores, lees sobre la historia de las estrellas que ha ganado el equipo y te tomas fotos con el plantel a través de pantallas digitales. Además, ubicamos taludes para que las personas tengan el mejor ángulo al momento de sacarse una selfie con La Aleta de fondo”, afirma Cure.',
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
            child: const Text('Aleta del Tiburón',
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