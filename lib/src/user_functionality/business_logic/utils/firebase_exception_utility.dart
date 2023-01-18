import 'package:fluttertoast/fluttertoast.dart';

void firebaseCurrentFailure(error){
  String errorMessage;
  switch (error.code) {
    case "invalid-email":
      errorMessage = "Your email address appears to be malformed.";

      break;
    case "wrong-password":
      errorMessage = "Your password is wrong.";
      break;
    case "user-not-found":
      errorMessage = "User with this email doesn't exist.";
      break;
    case "user-disabled":
      errorMessage = "User with this email has been disabled.";
      break;
    case "too-many-requests":
      errorMessage = "Too many requests";
      break;
    case "operation-not-allowed":
      errorMessage = "Signing in with Email and Password is not enabled.";
      break;
    default:
      errorMessage = "An undefined Error happened.";
  }
  Fluttertoast.showToast(msg: errorMessage);
}