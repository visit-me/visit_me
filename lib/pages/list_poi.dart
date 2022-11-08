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

class ListTileSelector extends StatefulWidget {
  const ListTileSelector({super.key});

  @override
  ListTileSelectorState createState() => ListTileSelectorState();
}

class ListTileSelectorState extends State<ListTileSelector> {
  bool shadowColor = false;
  bool isSelectionMode = false;
  final int listLength = 30;
  late List<bool> _selected;
  bool _selectAll = false;
  bool _isGridMode = false;

  @override
  void initState() {
    super.initState();
    initializeSelection();
  }

  void initializeSelection() {
    _selected = List<bool>.generate(listLength, (_) => false);
  }

  @override
  void dispose() {
    _selected.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const
          Text("VISIT-ME"),
        shadowColor: shadowColor ? Theme.of(context).colorScheme.shadow : null,
        backgroundColor:  Colors.white10,
        centerTitle:true,
          leading: isSelectionMode
              ? IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                isSelectionMode = false;
              });
              initializeSelection();
            },
          )
              : const SizedBox(),
          actions: <Widget>[
            if (_isGridMode)
              IconButton(
                icon: const Icon(Icons.grid_on),
                onPressed: () {
                  setState(() {
                    _isGridMode = false;
                  });
                },
              )
            else
              IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  setState(() {
                    _isGridMode = true;
                  });
                },
              ),
            if (isSelectionMode)
              TextButton(
                  child: !_selectAll
                      ? const Text(
                    'seleccinar todos',
                  )
                      : const Text(
                    'deseleccionar todos',
                  ),
                  onPressed: () {
                    _selectAll = !_selectAll;
                    setState(() {
                      _selected =
                      List<bool>.generate(listLength, (_) => _selectAll);
                    });
                  }),
          ],
        ),
        body: _isGridMode
            ? GridBuilder(
          isSelectionMode: isSelectionMode,
          selectedList: _selected,
          onSelectionChange: (bool x) {
            setState(() {
              isSelectionMode = x;
            });
          },
        )
            : ListBuilder(
          isSelectionMode: isSelectionMode,
          selectedList: _selected,
          onSelectionChange: (bool x) {
            setState(() {
              isSelectionMode = x;
            });
          },
        ));
  }
}

class GridBuilder extends StatefulWidget {
  const GridBuilder({
    super.key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  });

  final bool isSelectionMode;
  final Function(bool)? onSelectionChange;
  final List<bool> selectedList;

  @override
  GridBuilderState createState() => GridBuilderState();
}

class GridBuilderState extends State<GridBuilder> {
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: titles.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (_, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => listNav[index]),
              );
            },
            onLongPress: () {
              if (!widget.isSelectionMode) {
                setState(() {
                  widget.selectedList[index] = true;
                });
                widget.onSelectionChange!(true);
              }
            },
            child: GridTile(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70.withOpacity(0.0),
                      image: DecorationImage(
                        image: NetworkImage(img[index]),
                        fit: BoxFit.cover,
                      ),
                        boxShadow: [
                        BoxShadow(color: Colors.white, spreadRadius: 10),
                        ],
                        border: Border.all(
                        color: const Color(0xffffffff),
                        width: 10.0,
                        style: BorderStyle.solid),
                     ),

                  child: widget.isSelectionMode
                      ? Checkbox(
                      onChanged: (bool? x) => _toggle(index),
                      value: widget.selectedList[index]
                       )


                      :Container(
                         decoration: BoxDecoration(
                          color: Colors.white70.withOpacity(0.0),
                            image: DecorationImage(
                              image: NetworkImage(img[index]),
                                fit: BoxFit.cover,
                               ),
                           boxShadow: [
                             BoxShadow(color: Colors.white, spreadRadius: 2),
                           ],
                           border: Border.all(
                               color: const Color(0xffffffff),
                               width: 5.0,
                               style: BorderStyle.solid), //Border.all
                           /*** The BorderRadius widget  is here ***/
                           borderRadius: BorderRadius.all(
                             Radius.circular(5),
                           ),
                             )
                           ),
                        )
                       ),
          );
        });
  }
}

class ListBuilder extends StatefulWidget {
  const ListBuilder({
    super.key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  });

  final bool isSelectionMode;
  final List<bool> selectedList;
  final Function(bool)? onSelectionChange;

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount:titles.length,
        itemBuilder: (_, int index) {
          return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => listNav[index]),
                );
              },
              onLongPress: () {
                if (!widget.isSelectionMode) {
                  setState(() {
                    widget.selectedList[index] = true;
                  });
                  widget.onSelectionChange!(true);
                }
              },
              trailing: widget.isSelectionMode
                  ? Checkbox(
                value: widget.selectedList[index],
                onChanged: (bool? x) => _toggle(index),
              )
                  : const SizedBox.shrink(),
              title: Text(titles[index]),
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(img[index]))
           );
        });
  }
}

