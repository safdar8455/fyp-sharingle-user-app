import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/login/login_screen.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/mail-verification/mail_verification.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/phone-number-Screen/phone_no_screen.dart';
import 'package:sharingle_user_app/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:sharingle_user_app/src/features/core/screens/dashboard/darshboard.dart';
import 'package:sharingle_user_app/src/repository/authentication_repository/exception/firebase_exception.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // ignore: unused_field
  late Timer _codeAutoRetrievalTimer;

  //Variables
  late final Rx<User?> _firebaseUser;
  final _auth = FirebaseAuth.instance;
  final _phoneVerificationId = ''.obs;
  // late final GoogleSignInAccount _googleUser;

  User? get firebaseUser => _firebaseUser.value;

  String get getUserID => firebaseUser?.uid ?? "";

  String get getUserEmail => firebaseUser?.email ?? "";

  /// Load when app launch from main.dart
  @override
  void onReady() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    setInitialScreen(_firebaseUser.value);
  }

  setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => SplashScreen());
    } else {
      if (user.phoneNumber != null) {
        Get.offAll(() => const DashboardScreen());
      } else {
        Get.offAll(() => const PhoneScreen());
      }
    }
  }

  // setInitialScreen(User? user) async {
  //   if (user == null) {
  //     Get.offAll(() => SplashScreen());
  //   } else if (user.emailVerified) {
  //     if (user.phoneNumber != null) {
  //       final isProfileComplete = await getUserDetails(user.email.toString());
  //       if (!isProfileComplete) {
  //         Get.offAll(() => const DashboardScreen());
  //       } else {
  //         Get.offAll(() => MoreInfoScreen());
  //       }
  //     } else {
  //       Get.offAll(() => const PhoneScreen());
  //     }
  //   } else {
  //     Get.offAll(() => MailVerification());
  //   }
  // }

  setInitialLoginScreen(User? user) {
    if (user!.emailVerified) {
      if (user.phoneNumber != null) {
        Get.offAll(() => const DashboardScreen());
      } else {
        Get.offAll(() => const PhoneScreen());
      }
    } else {
      Get.offAll(() => MailVerification());
    }
  }

  // Future<bool> getUserDetails(String email) async {
  //   final snapshot = await FirebaseFirestore.instance
  //       .collection("Users")
  //       .where("Email", isEqualTo: email)
  //       .get();

  //   return snapshot.docs.map((e) => UserModel.fromSnapshot(e)).isEmpty;
  // }

  /**--------------------- Email & Pasword sign-in ----------------------- */
  /// [EmailAuthentication] - LOGIN
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = RsException.fromcode(e.code);
      Get.snackbar('Error', ex.message.toString());
    } catch (_) {
      const ex = RsException();
      Get.snackbar('Error', ex.toString());
    }
  }

  /// [ResetEmail] - Forgot Email and Password
  Future<void> ResetUserWithEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      final ex = RsException.fromcode(e.code);
      Get.snackbar('Error', ex.message.toString());
    } catch (_) {
      const ex = RsException();
      Get.snackbar('Error', ex.toString());
    }
  }

  /// [EmailAuthentication] - REGISTER
  Future<void> createUserWithEmaiAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = RsException.fromcode(e.code);
      Get.snackbar('Error', ex.message.toString());
      throw ex;
    } catch (_) {
      const ex = RsException();
      Get.snackbar('Error', ex.toString());
      throw ex;
    }
  }

  /// [EmailVerification] - VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final ex = RsException.fromcode(e.code);
      Get.snackbar('Error', ex.message.toString());
      throw ex;
    } catch (_) {
      const ex = RsException();
      Get.snackbar('Error', ex.toString());
      throw ex;
    }
  }

  /**------------------- Federal identity & Social sign-in ------------------ */

  /// [GoogleAuthentication] -GOOGLE
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final ex = RsException.fromcode(e.code);
      Get.snackbar('Error', ex.message.toString());
      throw ex;
    } catch (_) {
      const ex = RsException();
      Get.snackbar('Error', ex.toString());
      throw ex;
    }
  }

  /// [FacebookAuthentication] -FACEBOOK
  Future<UserCredential> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      final ex = RsException.fromcode(e.code);
      Get.snackbar('Error', ex.message.toString());
      throw ex;
    } catch (_) {
      const ex = RsException();
      Get.snackbar('Error', ex.toString());
      throw ex;
    }
  }

  /// [PhoneAuthentication] -LOGIN
  loginWithPhoneNo(String PhoneNumber) async {
    try {
      await _auth.signInWithPhoneNumber(PhoneNumber);
    } on FirebaseAuthException catch (e) {
      if (e.code == "Invalid-phone-number") {
        Get.snackbar("Error", "Invalid phone number.");
      }
    } catch (_) {
      Get.snackbar("Error", "Something went wrong.");
    }
  }

  /// [PhoneAuthentication] -REGISTER
  Future<void> phoneAuthentication(String phoneNo) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: Duration(milliseconds: 500),
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this._phoneVerificationId.value = verificationId;
          // Handle code auto-retrieval timeout if needed
          _codeAutoRetrievalTimer = Timer(Duration(minutes: 15), () {
            Get.snackbar('Timeout', 'Code auto-retrieval timed out');
          });
        },
        codeSent: (verificationId, resendingToken) {
          this._phoneVerificationId.value = verificationId;
          Get.to(() => OTPScreen(verificationField: phoneNo));
          // Handle code sent scenario if needed
        },
        verificationFailed: (e) {
          if (e.code == "invalid-phone-number") {
            Get.snackbar('Error', "The provided phone number is not valid");
          } else {
            Get.snackbar('Error', 'Something went wrong. Try again.');
          }
          throw e; // Rethrow the error for handling in the controller
        },
      );
    } catch (e) {
      print("Error during phone authentication: $e");
      throw e; // Rethrow the error for handling in the controller
    }
  }

  /// [PhoneAuthentication] -VERIFIY NO BY OTP
  Future<bool> verifyOTP(String otp) async {
    final credential = await PhoneAuthProvider.credential(
        verificationId: _phoneVerificationId.value, smsCode: otp);
    try {
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credential);
      return userCredential != null ? true : false;
    } on FirebaseAuthException catch (e) {
      final ex = RsException.fromcode(e.code);
      Get.snackbar('Error', ex.message.toString());
      throw ex;
    } catch (_) {
      const ex = RsException();
      Get.snackbar('Error', ex.toString());
      throw ex;
    }
  }

/**---------------------------- ./end Federated identity & Social sign-in */

  /// [LogoutUser] - Valid for any authentication
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      // await FacebookAuth.instance.logOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
      // await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } on FormatException catch (e) {
      throw e.message;
    } catch (e) {
      throw 'Unable to logout. Try again.';
    }
  }
}
