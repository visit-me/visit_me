import 'package:flutter/material.dart';
import 'package:visit_me/pages/venta_al_mundo_page.dart';

final titles = ['Favoritos'];

/* final   subtitles = [
  "Here is list 1 subtitle",
  "Here is list 2 subtitle",
  "Here is list 3 subtitle"
];
*/

final img = ["https://argos.co/wp-content/uploads/2021/04/argos-presente-en-la-construccion-de-la-ventana-al-mundo-simbolo-de-barranquilla.jpg"];
class FavPage extends StatelessWidget {
  const FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("VISIT-ME"),
            backgroundColor:  Colors.white10,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            centerTitle:true
        ),
    body: Center(
          child:ListView.builder(
              itemCount: titles.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                      /*onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),));
                      },*/
                      title: Text(titles[index]),
                      //subtitle: Text(subtitles[index]),
                      leading: Icon(Icons.favorite_border),
                      //trailing: Icon(icons[0])
                    ));
                  })
          )
    );
  }
}