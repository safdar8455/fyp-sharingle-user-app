class RsException implements Exception {
  final String message;
  const RsException([this.message = "An Unknown error occured."]);

  factory RsException.fromcode(String code) {
    switch (code) {
      case "weak-password":
        return const RsException("Please enter a stronger password.");
      case "invalid-email":
        return const RsException("Email is not valid or badly formatted.");
      case "email-already-in-use":
        return const RsException("An account already exists for that email.");
      case "operation-not-allowed":
        return const RsException(
            "Operation is not allowed. Please contact support.");
      case "user-disabled":
        return const RsException(
            "This user has been disabled. Please contact support for help.");
      case "invalid-password":
        return const RsException(
            "Credentials is not valid or badly formatted.");
      case "user-not-found":
        return const RsException("No user found for that email.");
      case "wrong-password":
        return const RsException("Wrong password provided for that user.");
      case "invalid-phone-number":
        return const RsException("The provided phone number is not valid.");
      case "too-many-requests":
        return const RsException(
            "Too many requests. Service Temporarily blocked.");
      case "invalid-argument":
        return const RsException(
            "An invalid argument was provided to an authentication method.");
      case "session-cookie-expired":
        return const RsException(
            "The provided Firebase session cookie is expired.");
      case "uid-already-exists":
        return const RsException(
            "The provided uid is already in use by an existing user.");
      case "provider-already-linked":
        return const RsException(
            "The provider has already been linked to the user.");
      case "invalid-credential":
        return const RsException("The provider's credential is not valid.");
      case "credential-already-in-use":
        return const RsException(
            "The account corresponding to the credential already exists, "
            "or is already linked to a Firebase User.");
      case "account-exists-with-different-credential":
        return const RsException(
            "An account already exists with the provided email address or phone number, "
            "but the provided credential is not for that account.");
      case "credential-mismatch":
        return const RsException(
            "The provided credential is not valid for the specified user.");
      case "user-token-expired":
        return const RsException("The user's session token has expired.");
      case "app-not-authorized":
        return const RsException(
            "The application is not authorized to perform the requested operation.");
      case "network-error":
        return const RsException(
            "A network error occurred while communicating with the Firebase Authentication service.");
      default:
        return const RsException();
    }
  }
}
