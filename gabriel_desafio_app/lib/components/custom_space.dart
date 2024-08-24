import 'package:flutter/material.dart';

class CustomSpace extends SizedBox {
  static const _base = 4;

  const CustomSpace({super.key, super.height, super.width});

  const CustomSpace.sp1({super.key})
      : super(
          height: _base * 1,
          width: _base * 1,
        );

  const CustomSpace.sp2({super.key})
      : super(
          height: _base * 2,
          width: _base * 2,
        );

  const CustomSpace.sp3({super.key})
      : super(
          height: _base * 3,
          width: _base * 3,
        );

  const CustomSpace.sp4({super.key})
      : super(
          height: _base * 4,
          width: _base * 4,
        );
}
