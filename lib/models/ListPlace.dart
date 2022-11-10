import 'package:cloud_firestore/cloud_firestore.dart';

class ListPlace {
  String? key;
  final String title;
  final String city;
  final String department;
  final String temperature;
  final String description;

  ListPlace({
    this.key,
    required this.title,
    required this.city,
    required this.department,
    required this.temperature,
    required this.description
  });

  Map<String, dynamic>tojSon() =>{
  'key': key,
  'title':title,
  'city': city,
  'department':department,
  'temperature':temperature,
  'description': description
  };

static ListPlace fromjSon(Map< String, dynamic>json)  =>
    ListPlace(
                key:json['key'],
                title:json['title'],
                city: json['city'],
                department: json['department'],
                temperature: json['temperature'],
                description:json['description']

              );

}

/*Stream <List<ListPlace>> getPlace()=>FirebaseFirestore.instance
      .collection('place')
      .snapshots().map((Snapshot) =>Snapshot.docs.map((doc) => ListPlace.fromjSon(doc.data())).toList());

 Future <ListPlace?> readPlace() async {
   final docPlace = FirebaseFirestore.instance.collection('place').doc('1');
   final snapshot = await docPlace.get();
   print(ListPlace.fromjSon(snapshot.data()!));
   if(snapshot.exists){
     print(ListPlace.fromjSon(snapshot.data()!));
     return ListPlace.fromjSon(snapshot.data()!);

   }

 }

 Widget buildPlace(ListPlace listplace) =>ListTile(
 title: Text(listplace.title),
 );*/