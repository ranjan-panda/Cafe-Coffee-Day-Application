//this file will include things which will be used many times
//in different sections
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  //hintText: 'Email',//even if we don't comment, it will get rewrited there with either password or email
  fillColor: Colors.white, //will only work when filled is true
  filled: true,
  //enabledBorder is only applying, when the field is not focussed
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  //border when field is focused
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);
