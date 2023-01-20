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
  String? descriptionValidation(value) {
    if (value.isEmpty) {
      return "Description Can't Empty";
    }
    return null;
  }

  String? dateValidation(value) {
    if (value.isEmpty) {
      return "Due Date Can't Empty";
    }
    return null;
  }

  String? taskValidation(value) {
    if (value.isEmpty) {
      return "Task Can't Empty";
    }
    return null;
  }

}

extension DateHelpers on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == this.day &&
        now.month == this.month &&
        now.year == this.year;
  }

}
