import 'package:cloud_firestore/cloud_firestore.dart';

extension FirestoreX on FirebaseFirestore {
  CollectionReference userItemsRef(String userId) =>
      collection("user-lists").doc(userId).collection("item-lists");
}
