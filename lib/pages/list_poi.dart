import 'package:flutter/material.dart';
import 'package:visit_me/pages/aleta_tiburon_page.dart';
import 'package:visit_me/pages/malecon_page.dart';
import 'package:visit_me/pages/venta_al_mundo_page.dart';
import 'package:visit_me/pages/tab_page.dart';

final titles = ['Ventana al mundo', 'Aleta del tiburón', 'Malecón'];
const listNav = [HomePage(), AletaPage(), MaleconPage()];

/* final   subtitles = [
  "Here is list 1 subtitle",
  "Here is list 2 subtitle",
  "Here is list 3 subtitle"
];*/

final img = [/*Ventana al mundo*/ "https://argos.co/wp-content/uploads/2021/04/argos-presente-en-la-construccion-de-la-ventana-al-mundo-simbolo-de-barranquilla.jpg",
/*Alweta del tiburón*/ "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhCDqApAjc7-LZ0NolZ4ehlWxj5Tv521Ty_A&usqp=CAU",
/*Malecón*/ "https://www.elespectador.com/resizer/7dPYuMzBE77eu5SVPqQkoY3950Y=/525x350/filters:format(jpeg)/cloudfront-us-east-1.images.arcpublishing.com/elespectador/ZBHIOHNLUZF2JINOTQ7KODYENI.jpeg",

];
class ListPoi extends StatelessWidget {
  const ListPoi({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => listNav[index]),
                    );
                  },
                  title: Text(titles[index]),
                  //subtitle: Text(subtitles[index]),
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(img[index])),
                  //trailing: Icon(Icons.favorite_border)
          ));
        });
  }
}