// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthService {
//   final FirebaseAuth _fAuth = FirebaseAuth.instance;
//
//   Future signInWithPhone(String phone) async {
//     try{
//       ConfirmationResult authResult = await _fAuth.signInWithPhoneNumber(phone);
//       User user = authResult.user;
//       return user;
//     }catch(e){
//       return null;
//     }
//   }
// }