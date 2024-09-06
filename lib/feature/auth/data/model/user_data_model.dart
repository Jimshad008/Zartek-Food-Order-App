import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zartek_task/feature/auth/domain/entities/user_data.dart';
import 'package:zartek_task/feature/home/data/model/category_data_model.dart';

class UserDataModel extends UserData{


//<editor-fold desc="Data Methods">
  UserDataModel({
    required super.data,
    required super.id,
    required super.cart,
    required super.reference,
  });


  UserDataModel copyWith({
    String? data,
    String? id,
    List<DishesModel>? cart,
    DocumentReference? reference,
  }) {
    return UserDataModel(
      data: data ?? this.data,
      id: id ?? this.id,
      cart: cart ?? this.cart,
      reference: reference ?? this.reference,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': this.data,
      'id': this.id,
     'cart': cart.isEmpty
          ? []
          : List<dynamic>.from(cart.map((x) => x.toMap())),
      "reference":this.reference,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      data: map['data']??"",
      id: map['id']??"",
      reference: map['reference']??"",
      cart:map['cart']== null
          ? []: map['cart'].length==0?[]
          : List<DishesModel>.from( map['cart']!.map((x) => DishesModel.fromMap(x))),
    );
  }

//</editor-fold>
}