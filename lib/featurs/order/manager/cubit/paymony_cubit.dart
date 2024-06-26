import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/Core/servers/data_base_methouds.dart';
import 'package:meta/meta.dart';

part 'paymony_state.dart';

class PaymonyCubit extends Cubit<PaymonyState> {
  PaymonyCubit() : super(PaymonyInitial());

  Future<void> paymony(int totalPrice) async {
    // ignore: prefer_typing_uninitialized_variables
    emit(PaymonyLoading());
    var documentId = FirebaseAuth.instance.currentUser!.uid;

    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .get();
    int currentWallet = snapshot.data()!['Wallet'];

    if (totalPrice != 0) {
      if (currentWallet >= totalPrice) {
        int newWalletBalance = currentWallet - totalPrice;
        FirebaseFirestore.instance.collection('users').doc(documentId).update(
          {'Wallet': newWalletBalance},
        );
        DataBaseMethouds().deleteCurt(documentId);

        emit(PaymonySuccess());
      } else {
        emit(PaymonyError());
      }
    } else {
      emit(PayZeroError());
    }
  }
}
