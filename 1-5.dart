import 'dart:math';

class DelimetersCalculator {
  int? first;
  int? second;

  int gcd(int first, int second) //НОД
  {
    first = first.abs();
    second = second.abs();

    return second == 0 ? first : gcd(second, first % second);
  }

  int lcm(int first, int second) //НОК
  {
    return (first == 0 || second == 0)
        ? 0
        : first ~/ gcd(first, second) * second;
  }

  /*List<int> primeFactors(int number) //разделить число на простые множители
  {
    List <int> listOfPrimeFactors;

    for (int i = (number ~/ 2); i > 0 ; i--)
    {

    }
    return List<int> listOfPrimeFactors;
  }*/
}

//2. Перевод из бинарной СС в десятичную и наоборот
class ConversionCalculator {
  String toBinary(int decimalNumber) {
    List<String> binaryForm = [];
    while (decimalNumber != 0) {
      binaryForm.add((decimalNumber % 2).toString());
      decimalNumber ~/= 2;
    }
    return (binaryForm.reversed).join();
  }

  int toDecimal(String binaryNumber) {
    double decimalForm = 0;
    String reversedBinaryNum = ((binaryNumber.split("")).reversed).join();
    int binaryNumberLength = reversedBinaryNum.length;

    for (int i = 0; i < binaryNumberLength; i++) {
      decimalForm += double.parse(reversedBinaryNum[i]) * pow(2, i);
    }
    return decimalForm.toInt();
  }
}

//3-5
class ElementsSelection {
  bool isNum(String strForCheck) {
    //к №3
    //функция проверки на число
    int dotCounter = 1;
    int minusCounter = 1;

    for (int i = 0; i < strForCheck.length; i++) {
      //проверка, равен ли символ 0-9
      bool conditionNum =
          48 <= strForCheck.codeUnitAt(i) && strForCheck.codeUnitAt(i) <= 57;
      //проверка, если символ точка и входит один раз и не первой и последней позицией в строке
      bool conditionComma = strForCheck[i] == '.' &&
          i != 0 &&
          i != strForCheck.length - 1 &&
          '.'.allMatches(strForCheck).length == 1;
      //проверка, если символ - это минус и входит единожды и только первой позицией
      bool conditionMinus = strForCheck[i] == '-' &&
          i == 0 &&
          '-'.allMatches(strForCheck).length == 1;

      if (conditionNum || conditionComma || conditionMinus) {
        //если что-то верно
        continue;
      }

      return false; //если все три условия не выполняются, то строка не подходит
    }
    return true;
  }

//№3
  List<String> numbersSearch(String words) {
    //задание 3
    List<String> Num = [];
    List<String> splitWords = words.split(" ");
    for (final element in splitWords) {
      if (isNum(element) == true) {
        //проверка на число (десятичное, целое, отрицательное)
        Num.add(element);
      }
    }
    return Num;
  }

//№4
  Map<String, int> wordCounter(List<String> words) {
    Map<String, int> wordCount = {};

    for (final element in words) {
      if (wordCount.containsKey(element)) {
        wordCount[element] = wordCount[element]! + 1;
      } else {
        wordCount[element] = 1;
      }
    }
    return wordCount;
  }

//№ 5
  Set<int> stringToNum(List<String> words) {
    Set<int> convertedNums = {};
    Map<String, int> wordsNums = {
      "zero": 0,
      "one": 1,
      "two": 2,
      "three": 3,
      "four": 4,
      "five": 5,
      "six": 6,
      "seven": 7,
      "eight": 8,
      "nine": 9
    };
    for (final element in words) {
      if (wordsNums.containsKey(element.toLowerCase())) {
        convertedNums.add(wordsNums[element.toLowerCase()]!);
      }
    }
    return convertedNums;
  }
}

class Point {}

void main() {
  final newNumbers = DelimetersCalculator();
  {
    print(newNumbers.gcd(1, 20));
    print(newNumbers.gcd(-1, -20));
    print(newNumbers.gcd(2, 0));
    print(newNumbers.gcd(4, 80));
    print(newNumbers.gcd(80, 4));
    print(newNumbers.gcd(0, 7));
    print(newNumbers.gcd(0, 0));
    print(newNumbers.gcd(-2, 0));
  }
  print("\n");
  {
    print(newNumbers.lcm(0, 5));
    print(newNumbers.lcm(25, 10));
    print(newNumbers.lcm(10000, 30));
    print(newNumbers.lcm(0, 0));
  }
  print("\n");
  final convertedNum = ConversionCalculator();
  {
    print(convertedNum.toBinary(54));
    print(convertedNum.toBinary(14401));
    print(convertedNum.toBinary(1));
    print(convertedNum.toDecimal("110"));
    print(convertedNum.toDecimal("1011010"));
  }
  print("\n");
  final selectedSequence = ElementsSelection();
  {
    List<String> answer;
    answer = selectedSequence.numbersSearch(
        "cat dog 100b 105 55 2.5 2.5.5 .25 25. 1-0 -10 10- -10- -2.5 meow5");
    for (final element in answer) {
      print(element);
    }
  }
  print("\n");
  {
    Map<String, int> answer;
    List<String> words = [
      "one",
      "one",
      "cat",
      "dog",
      "fox",
      "dog",
      "frog",
      "one"
    ];
    answer = selectedSequence.wordCounter(words);
    for (final element in answer.keys) {
      print("$element: ${answer[element]}");
    }
  }
  print("\n");
  {
    List<String> words = [
      "cat",
      "fox",
      "OnE",
      "Two",
      "two",
      "three",
      "8",
      "seven",
      "Zero",
      "zero",
      "rabbit",
      "rabbitone"
    ];

    Set<int> answer;
    answer = selectedSequence.stringToNum(words);
    for (final element in answer) {
      print(element);
    }
  }
  print("\n");
}
