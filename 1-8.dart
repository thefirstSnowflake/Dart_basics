import 'dart:math';

class DelimetersCalculator {
  int? first, second;

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

  bool isPrime(int number) //проверка простого числа
  {
    for (int i = 2; i < number ~/ 2; i++){
      if (number % i == 0){
        return false;
      }
    }
    return true;
  }

  List<int> primeFactors(int number) //разделить число на простые множители
  {
    List <int> listOfPrimeFactors = [1];
    int i = 2; //начальный делитель
    while(i != number){
      if (number % i == 0 && isPrime(i) == true)
      {
        listOfPrimeFactors.add(i);
        number ~/= i; //если число добавилось в список, то множитель остается прежним для след. числа
      }
      else{
        i++; //если не добавилось, то ищем множитель дальше
      }
    }
    if (isPrime(number) == true){ //выполнится, если даже начальное число простое
      listOfPrimeFactors.add(number);
    }
    return listOfPrimeFactors;
  }
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

//№6
class Point {
  final int? x, y, z;

  Point(this.x, this.y, this.z);

  factory Point.startCoord() {
    return Point(0, 0, 0);
  }

  factory Point.unitVector() {
    return Point(1, 1, 1);
  }

  void displayFact() {
    print("$x $y $z");
  }

  double distanceTo(Point another) {
    return sqrt(pow((another.x! - x!), 2) +
        pow((another.y! - y!), 2) +
        pow((another.z! - z!), 2));
  }
}

//высчитать площадь треугольника по трем точкам
double getTriangleSquare(Point a, Point b, Point c) {
  List<int> ab = [
    b.x! - a.x!,
    b.y! - a.y!,
    b.z! - a.z!
  ]; //получим координаты векторов AB и AC
  List<int> ac = [c.x! - a.x!, c.y! - a.y!, c.z! - a.z!];
  List<int> vecProduct = [
    //вычислим миноры
    ab[1] * ac[2] - ac[1] * ab[2],
    -(ab[0] * ac[2] - ac[0] * ab[2]),
    ab[0] * ac[1] - ac[0] * ab[1]
  ];

  return 1 / //вычислим площадь
      2 *
      sqrt(pow(vecProduct[0], 2) +
          pow(vecProduct[1], 2) +
          pow(vecProduct[2], 2));
}

//№7
extension on num {
  //расширяем функкционал num
  double power(int pow) {
    //доп. метод для вычисления степени
    double numInPow = 1;
    for (int i = 1; i <= pow; i++) {
      numInPow *= this;
    }
    return numInPow;
  }

  double getNRoot(int powRoot) {
    //метод для нахождения корня n-й степени
    //коллекция аргументированных исключений (всегда можно дополнить)
    Map<bool, String> errorsCollect = {
      this < 0: "Negative number under the root.",
      powRoot == 0: "The power cannot be zero."
    };

    for (final element in errorsCollect.keys) {
      //поочередно проверяем все исключения
      if (element == true) {
        throw ArgumentError(errorsCollect[element]);
      }
    }

    double anyExpected = 1; //пусть ожидаемый результат = 1
    double root = 0; //начальное значение корня

    while (true) {
      root = (1 / powRoot) *
          ((powRoot - 1) * anyExpected +
              (this / anyExpected.power(powRoot - 1)));
      if (root == anyExpected) {
        break;
      }
      anyExpected = root;
    }

    return root;
  }
}

class User {
  final int id;
  final String status;
  String? email; //почта

  User(this.id, this.status, this.email);
}

class AdminUser extends User with cutMail { //наследник от User - администратор, на который повешен миксин
  //1-й наследник
  AdminUser(int id, String status, String email) : super(id, status, email);
}

mixin cutMail on User {
  //миксин
  //геттер, в котором возвращается название почтовой системы
  String get getMailSystem =>
      email!.substring(email!.indexOf("@") + 1, email!.length); //возвращает подстроку после @ в почте
}

class GeneralUser extends User {
  //2-й наследник
  GeneralUser(int id, String status, String email) : super(id, status, email);
}

class userManager<T extends User> { //Т - обязательно User или его наследник
  //generic
  List<T> listOfUsers = []; 

  void addUser(T user) {
    listOfUsers.add(user);
  }

  void deleteUser(T user) {
    listOfUsers.remove(user);
  }

  void getUsers() {
    for (T user in listOfUsers) {
      if (user.status == "admin") {
        AdminUser adminUser = user as AdminUser;
        print("${user.id} ${user.status} ${user.getMailSystem}");
      }
      else{ 
        print("${user.id} ${user.status} ${user.email}");
      }
    }
  }
}

void main() {
  //№1
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

    print(newNumbers.lcm(0, 5));
    print(newNumbers.lcm(25, 10));
    print(newNumbers.lcm(10000, 30));
    print(newNumbers.lcm(0, 0));

    List<int> listOfPrimeAnswer = newNumbers.primeFactors(135643); //разложение на простые множители
    for (final factor in listOfPrimeAnswer)
    {
      print("Prime factor: $factor");
    }

  }
  //№2
  print("\n");
  final convertedNum = ConversionCalculator();
  {
    print(convertedNum.toBinary(54)); //в двоичную
    print(convertedNum.toBinary(14401));
    print(convertedNum.toBinary(1));
    print(convertedNum.toDecimal("110")); //в десятичную СС
    print(convertedNum.toDecimal("1011010"));
  }
  print("\n");
  //№3-5
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
  //№6
  print("\n");
  {
    final myPoint = Point(3, 7, -2);
    print(myPoint.distanceTo(Point(6, 10, 1)));
    print(myPoint.distanceTo(Point(1, 4, 6)));

    print(myPoint.distanceTo(Point.startCoord()));
    print(myPoint.distanceTo(Point.unitVector()));

    print(
        "Triangle square: ${getTriangleSquare(Point(1, 0, 6), Point(4, 5, -2), Point(7, 3, 4))}");
  }
  print("\n");
  {
    //№ 7 тесты

    print(27.getNRoot(3)); //будет 3
    print(16.getNRoot(2)); //4
    print(100500.getNRoot(5));
    // print(1000500.getNRoot(0)); //исключение
    //print((-27).getNRoot(3)); //исключение

    /* попробуем try-catch
    double root;
    try { 
      root = 1000500.getNRoot(0); //выпадет с исключением, т.к. корень в 0 степени
    }catch (e){
      print("Exception thrown.");
    }

    try {
      root = (-27).getNRoot(3); //выпадет с исключением, т.к. число < 0
    }catch (e){
      print("Exception thrown.");
    }*/
  }
  print("\n");
  //№8
  {
    final dataOfUsers = userManager(); //объект с набором пользователей
    {
      final newUser = AdminUser(123, "admin", "user173@mail.ru");
      final newUser1 = AdminUser(456, "user", "user273@gmail.com");
      final newUser2 = AdminUser(789, "admin", "user373@yandex.ru");
      dataOfUsers.addUser(newUser);
      dataOfUsers.addUser(newUser1);
      dataOfUsers.addUser(newUser2);

      dataOfUsers.getUsers();
    }
  }
}
