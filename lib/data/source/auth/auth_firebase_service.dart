import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:drdrakify/core/configs/constants/app_urls.dart';
import 'package:drdrakify/data/models/auth/create_user_request.dart';
import 'package:drdrakify/data/models/auth/signin_user_request.dart';
import 'package:drdrakify/data/models/auth/user.dart';
import 'package:drdrakify/domain/entities/auth/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthFirebaseService {
  Future<Either<String, String>> signup(CreateUserRequest createUserReq);
  Future<Either<String, String>> signin(SigninUserRequest signinUserRequest);
  Future<Either<String, UserEntity>> getUser();
}

class AuthFirebaseSeviceImplementation extends AuthFirebaseService {
  @override
  Future<Either<String, String>> signin(
      SigninUserRequest signinUserRequest) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinUserRequest.email,
        password: signinUserRequest.password,
      );

      return const Right('SignIn was Successful');
    } on FirebaseAuthException catch (e) {
      String message = '';

      print('Error code: ${e.code}'); // Log the error code for debugging
      print(
          'Error message: ${e.message}'); // Log the error message for debugging

      switch (e.code) {
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        case 'user-not-found':
          message = 'No user found for this email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided for this user.';
          break;
        case 'user-disabled':
          message = 'This user has been disabled.';
          break;
        case 'too-many-requests':
          message = 'Too many requests. Try again later.';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled.';
          break;
        case 'invalid-password':
          message = 'Wrong password provided for this user.';
          break;
        case 'invalid-credential':
          message = 'Invalid-credentials';
          break;
        default:
          message = 'An unknown error occurred';
      }

      print(message);
      return Left(message);
    }
  }

  @override
  Future<Either<String, String>> signup(CreateUserRequest createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );

      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set(
        {
          'name': createUserReq.fullName,
          'email': data.user?.email,
        },
      );

      return const Right('Signup was Successful');
    } on FirebaseAuthException catch (e) {
      String message = '';

      switch (e.code) {
        case 'weak-password':
          message = 'The password is too weak.';
          break;
        case 'email-already-in-use':
          message = 'An account already exists with this email.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled.';
          break;

        default:
          message = 'An unknown error occurred.';
      }

      return Left(message);
    }
  }

  @override
  @override
  Future<Either<String, UserEntity>> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var currentUser = firebaseAuth.currentUser;
      if (currentUser == null) {
        return const Left('No user is currently logged in');
      }

      var userDoc = await firebaseFirestore
          .collection('Users')
          .doc(currentUser.uid)
          .get();

      if (!userDoc.exists) {
        return const Left('User document does not exist');
      }

      print('User document data: ${userDoc.data()}'); // Debug print

      UserModel userModel = UserModel.fromJson(userDoc.data()!);
      userModel.imageURl = currentUser.photoURL ?? AppURLs.defaultImg;

      // Check if types match
      print('UserModel: $userModel');
      print('Converted User: ${userModel.toEntity()}');

      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    } catch (e, stackTrace) {
      print('Exception caught: $e');
      print('Stack trace: $stackTrace');
      return const Left('An error occurred while fetching user data');
    }
  }
}
