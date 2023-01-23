import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task_widget_model.dart';

class Services {
  addDataToCollection (Model model)async{
  await FirebaseFirestore.instance.collection('msgs').doc().set(model.toJson());
}
deletePost (String uid)async{
  return FirebaseFirestore.instance.collection('msgs').doc(uid).delete();
}
}