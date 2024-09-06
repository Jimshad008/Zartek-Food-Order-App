import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../home/data/model/category_data_model.dart';

class UserData{
  final String data;
  final String id;
  final List<DishesModel> cart;
  final DocumentReference reference;
  UserData({required this.data,required this.id,required this.cart,required this.reference});
}