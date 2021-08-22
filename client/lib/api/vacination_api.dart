import 'package:apps/api/model/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VacinationAPI {
  Future<Data> getBrazilTotal() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.doc("brazil_total/TOTAL").get();
    return Data.fromSnapshot(snapshot.data() as Map<String, dynamic>);
  }

  Future<Data> getData(String code) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.doc("brazil_total/" + code).get();
    return Data.fromSnapshot(snapshot.data() as Map<String, dynamic>);
  }
}
