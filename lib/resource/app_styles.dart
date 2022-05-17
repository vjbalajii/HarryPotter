import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:harry_potter/resource/app_constants.dart';

import 'app_colors.dart';

abstract class AppStyles {

  static TextStyle textTitleBlack = TextStyle(
      color: AppColors.black,
      fontSize: 22,
      fontWeight: FontWeight.w300);

  static TextStyle textTitleWhite = TextStyle(
      color: AppColors.white,
      fontSize: 26,
      fontWeight: FontWeight.w300);

  static TextStyle textDetailPrimaryBold = TextStyle(
      color: AppColors.primary,
      fontSize: 14,
      fontWeight: FontWeight.w600);

  static TextStyle textTitleBlackBold = TextStyle(
      color: AppColors.black,
      fontSize: 22,
      fontWeight: FontWeight.w600);

  static TextStyle textTitleWhiteBold = TextStyle(
      color: AppColors.white,
      fontSize: 22,
      fontWeight: FontWeight.w600);

  static TextStyle textSubTitleBlack = TextStyle(
      color: AppColors.black,
      fontSize: 22,
      fontWeight: FontWeight.w300);

  static TextStyle textSubTitleWhite = TextStyle(
      color: AppColors.white,
      fontSize: 16,
      fontWeight: FontWeight.w300);

  static TextStyle textSubTitleBlackBold = TextStyle(
      color: AppColors.black,
      fontSize: 22,
      fontWeight: FontWeight.w500);

  static TextStyle textDetailBlack = TextStyle(
      color: AppColors.black,
      fontSize: 14,
      fontWeight: FontWeight.w300);

  static TextStyle textDetailBlackBold = TextStyle(
      color: AppColors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500);

  static TextStyle textBodyBlack = TextStyle(
      color: AppColors.black,
      fontSize: 12,
      fontWeight: FontWeight.w300);

  static TextStyle textBodyBlackBold = TextStyle(
      color: AppColors.black,
      fontSize: 12,
      fontWeight: FontWeight.w600);

}