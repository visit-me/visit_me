import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:visit_me/pages/PlaceView.dart';

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

    final ListBox = GetStorage();
    List titles = ListBox.read('Titles');
    List img = ListBox.read('Urls');

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
    final ListBox = GetStorage();
    List titles = ListBox.read('Titles');
    List img = ListBox.read('Urls');

    return GridView.builder(
        itemCount: titles.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (_, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => loadingPage(p:index,url:img[index])),
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
                             ),
                           child:Align(
                               alignment: Alignment.bottomCenter,
                               child:Container(
                                   decoration: BoxDecoration(
                                   color: Colors.white38),
                                   child:

                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: [
                                       Container(
                                       height: 25,
                                       child:Text(titles[index],
                                           style: TextStyle(fontSize: 12.0)
                                       ),)]
                                       )
                               )) ,
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
    final ListBox = GetStorage();
    List titles = ListBox.read('Titles');
    List img = ListBox.read('Urls');
    return ListView.builder(
        itemCount:titles.length,
        itemBuilder: (_, int index) {
          return ListTile(
              onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>loadingPage(p:index,url:img[index])),
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

/*class loadingPage extends StatefulWidget {
  const loadingPage({super.key, required int p});

  @override
  State <loadingPage> createState() => _loadingPageState();

}

class _loadingPageState extends State<loadingPage> {
  @override

  var p = 0;
  dynamic place = {0:{'city':"killa"}};

  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('place');

  Future<Map> getPlace() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    Map ListPlace = allData.asMap();

    setState(() {
      place = ListPlace;
    });

    return ListPlace;
  }

  @override
  void initState() {
    getPlace();
    super.initState();
  }


  Widget build(BuildContext context) {
    var Ancho = screenWidth(context, dividedBy: 1);
    return Scaffold(
       body:
        FutureBuilder<Map>(
            future: getPlace(),
            builder: (BuildContext context, AsyncSnapshot<Map> snapshot){

              Map? killa = snapshot.data!;
              int p = _loadingPageState().p;

             if(snapshot.data! == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else{
              if(killa == null) {
              return Center(
              child: CircularProgressIndicator(),
              );
              } else{

                return Stack(children:<Widget>[
                Container(
                  height: 320.0,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFFB2DFDB),
                            Color(0xFFB2DFDB)
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(0.0, 1.5),
                          stops: [0.0, 0.5],
                          tileMode: TileMode.clamp
                      )
                  ),
                ),Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                        height: 300,
                        child: Container(
                          height: 200,
                          width: (Ancho-20),
                          margin: const EdgeInsets.only(
                              top:10 ,
                              left: 10,
                              right: 10
                          ),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('')
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              shape: BoxShape.rectangle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 0,
                                    offset: Offset(0.0, 7.0)
                                )
                              ]
                          ),
                        )
                    )
                ),
                //DescriptionPlace()
                ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(children: [Container(height: 240,)],),

                          Align(
                            //alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 20,
                                  left: 20.0,
                                  right: 20.0
                              ),
                              child: Text( killa[p]['title'],
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w900
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),


                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 20.0,
                                  left: 20.0,
                                  right: 20.0
                              ),
                              child: Text('Ciudad: '+killa[p]['city'],
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(
                                //top: 20.0,
                                  left: 20.0,
                                  right: 20.0
                              ),
                              child: Text('Departamento: '+killa[p]['department'],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(
                                //top: 20.0,
                                  left: 20.0,
                                  right: 20.0
                              ),
                              child: Text('Temperatura: '+killa[p]['temperature'],
                                style: TextStyle(
                                  fontSize: 16.0,),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(
                                top: 20.0,
                                right: 20.0,
                                left: 20.0
                            ),
                            child: Text(killa[p]['description'],
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),

                        ],
                      );
                    })
              ]
              );

            }}}
        )
    );
  }


}
*/

