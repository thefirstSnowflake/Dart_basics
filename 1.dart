import 'package:dart_application_1/dart_application_1.dart' as dart_application_1;


class DelimetersCalculator
{
  int? first;
  int? second;
  int gcd(int first, int second) //НОД
  {
    if (second == 0){
      return 0;
    }
    int remainder = first % second;
    while (remainder != 0){
      first = second;
      second = remainder;
      remainder = first % second;
    }
    return second;
  }

double lcm(int first, int second) //НОК
  {
    return (first * second)/(gcd(first, second));
  }

 /* List<int> primeFactors() //разделить число на простые множители
  {

  }*/

  
}

void main() {
  final newNumbers = DelimetersCalculator();
  print(newNumbers.gcd(1, 20));
  print(newNumbers.gcd(2, 0));
  print(newNumbers.gcd(4, 80));
  print(newNumbers.gcd(80, 4));
  print(newNumbers.gcd(0, 7));
  print(newNumbers.gcd(10000, 30));
  print(newNumbers.lcm(100, 50));
}
