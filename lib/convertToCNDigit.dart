// Copyright 2015 the Dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

import 'dart:math';

const CN_0 = "零";
const CN_1 = "壹";
const CN_2 = "貳";
const CN_3 = "叁";
const CN_4 = "肆";
const CN_5 = "伍";
const CN_6 = "陸";
const CN_7 = "柒";
const CN_8 = "捌";
const CN_9 = "玖";

const CN_Digits = [CN_0, CN_1, CN_2, CN_3, CN_4, CN_5, CN_6, CN_7, CN_8, CN_9];

const CN_dollar = "元";
const CN_integralOnly = "正";

const CN_pt1 = "角";
const CN_pt01 = "分";

const CN_pts = [CN_pt1, CN_pt01];

const CN_10 = "拾";
const CN_100 = "佰";
const CN_1000 = "仟";

const CN_BasePosition = ["", CN_10, CN_100, CN_1000];

const CN_10000 = "萬";
// const CN_100000000 = "億";

// TODO switch to decimal package (https://pub.dev/packages/decimal)

String convertToCN(String input){
  var spiltted = input.split(".");

  // remove leading zeros and comma
  spiltted[0] = spiltted[0].replaceAll(RegExp(r"^0+"), "").replaceAll(",", "");
  
  var integral = convertToCNIntegral(spiltted[0]);
  var fractional = spiltted.length == 2 ? convertToCNFractional(spiltted[1]) : "";
  
  return
    (integral.isNotEmpty ? integral + CN_dollar : "") +
      (fractional.isNotEmpty ? fractional : "") + 
        (fractional.isEmpty && integral.isNotEmpty ? CN_integralOnly : "");
}

String convertToCNIntegral(String input) {
  var result = "";

  var reversed = input.split("").reversed.toList();
  var chucks = [];

  for (var i = 0; i < reversed.length; i += 4) {
    chucks.add(reversed.sublist(i, min(i + 4, reversed.length)));
  }

  chucks.asMap().forEach((key, val) {
    if (key == 1) {
      result = CN_10000 + result;
    }

    if (true) {
      var subResult = val.asMap().entries.toList().fold("", (acc, elem) {
        var key = elem.key;
        var val = elem.value;

        var d = int.parse(val);

        if (d > 0) {
          if (d == 1 && key % 4 == 1) {
            return CN_BasePosition[key % 4] + acc;
          } else {
            return CN_Digits[d] + CN_BasePosition[key % 4] + acc;
          }
        } else {
          if (acc.isNotEmpty && acc[0] != CN_0) {
            return CN_0 + acc;
          }
        }

        return acc;
      });

      result = subResult + result;
    }
  });

  return result;
}

String convertToCNFractional(String input){
  return input.split("").asMap().entries.fold("", (acc, elem){
    var key = elem.key;
    var val = elem.value;
    
    var d = int.parse(val);
    
    if(d > 0){
      acc += CN_Digits[d] + CN_pts[key];
    }
    
    return acc;
  });
}

void main() {
  var testInputs = [
    "132001",
    "132010",
    "132100",
    "132000",
    "10000000",
    "232000",
    "2320000",
    "23200000",
    "00100",
    ".11",
    "0.12",
    ".01",
    "0.9",
    ".00",
    "0.34"
  ];

  for (var input in testInputs) {
    print("for $input gives ${convertToCN(input)}");
  }
}
