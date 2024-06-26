
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorproject/7doctor/cubit/cubit.dart';
import 'package:doctorproject/7doctor/moduels/loginmodel/logincubit/state.dart';
import 'package:doctorproject/models/usermodel.dart';
import 'package:doctorproject/shared/components/shared/shared.dart';
import 'package:doctorproject/shared/constants/constants.dart';
import 'package:doctorproject/shared/shared_preferense/sharedPreferense.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState>{
   LoginCubit():super(InitialLoginState());

   static LoginCubit get(context)=>BlocProvider.of(context);
   IconData visableIcon=Icons.visibility_off;
   bool isVisable=true;
   String selectedRole = 'User';
    void ChangeRole(String value){
      selectedRole=value;
      SharedHelper.SaveData(key: 'role', value: selectedRole);
      role=SharedHelper.getData(key: 'role');
      emit(ChangeRoleState());

    }

   void ChangeVisable(){
     isVisable=!isVisable;
     visableIcon=isVisable ? Icons.visibility_off :Icons.visibility;
     emit(ChangeVisablePasswordLogin());

   }
   void LoginUserData(context,{
     required String email,
     required String password
 }){
     emit(LoadingLoginUserState());
     FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email,
         password: password).then((value) {
           print(value.user!.email);
           print(value.user!.uid);
           uid=value.user!.uid;
           DoctorCubit.get(context).getUserData();
           emit(LoginUserSuccessfully(value.user!.uid));

     }).catchError((error){
       emit(LoginUserError(error.toString()));

     });

   }

   void LoginDoctorData(context,{
     required String email,
     required String password
   }){
     emit(LoadingLoginUserState());
     FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email,
         password: password).then((value) {
       print(value.user!.email);
       print(value.user!.uid);
       uid=value.user!.uid;
      // DoctorCubit.get(context).getDoctorData();
       emit(LoginDoctorSuccessfully(value.user!.uid));

     }).catchError((error){
       emit(LoginDoctorError(error.toString()));

     });

   }





 }