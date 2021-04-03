import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModel extends Model {
  @override
  void addListener(VoidCallback listeners) {
    super.addListener(listeners);
    _loadCurrentUser();
  }

  bool isLoading = false;

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  FirebaseAuth _auth = FirebaseAuth.instance;
  User firebaseUser;
  Map<String, dynamic> userData = Map();

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: userData['email'], password: pass)
        .then((value) async {
      firebaseUser = value.user;
      await _saveUserData(userData);
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn(
      {@required email,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();
    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) async {
      await _loadCurrentUser();
      firebaseUser = value.user;
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .set(userData);
  }

  void signOut() async {
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      if (userData['name'] == null) {
        DocumentSnapshot docUser = await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .get();

        userData = docUser.data();
      }
    }
    notifyListeners();
  }
}
