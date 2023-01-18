import '../../services/dependency_assembler_education.dart';

class Validations {
  String? nameValidation(value) {
    RegExp regex = new RegExp(r'^.{3,}$');
    if (value!.isEmpty) {
      return ("Name cannot be Empty");
    }
    if (!regex.hasMatch(value)) {
      return ("Enter Valid name(Min. 3 Character)");
    }
    return null;
  }

  String? emailValidation(value){
    if (value!.isEmpty) {
      return ("Please Enter Your Email");
    }
    // reg expression for email validation
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(value)) {
      return ("Please Enter a valid email");
    }
    return null;
  }

  String? passwordValidation(value) {
    RegExp regex = new RegExp(r'^.{6,}$');
    if (value!.isEmpty) {
      return ("Password is required for register");
    }
    if (!regex.hasMatch(value)) {
      return ("Enter Valid Password(Min. 6 Character)");
    }
  }

 /* String? confirmPasswordValidation(value) {
    final AuthenticationViewModel auth =
        dependencyAssembler<AuthenticationViewModel>();
    RegExp regex = new RegExp(r'^.{6,}$');
    if (value!.isEmpty) {
      return ("Confirm Password is required for register");
    }
    if (!regex.hasMatch(value)) {
      return ("Enter Valid Confirm Password(Min. 6 Character)");
    }
    if (auth.passwordController.text != value.toString()) {
      return ('Password must be same as above');
    }
    return null;
  }*/
}
