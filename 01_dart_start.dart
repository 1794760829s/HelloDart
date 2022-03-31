// Importing core libraries
import 'dart:math';

//变量 https://dart.cn/samples#variables
void variables() {
  var name = 'Voyager I';
  var year = 1997;
  var antennaDiameter = 3.7;
  var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
  var image = {
    'tags': ['saturn'],
    'url': '//path/to/saturn.jpg'
  };
  print(
      'name is $name, year is $year, antennaDiameter is $antennaDiameter, flybyObjects is $flybyObjects, image is $image');

  flow_control(year, flybyObjects); //流程控制
  flybyObjects.where((name) => name.contains('turn')).forEach(print); //匿名函数
}

//流程控制语句 https://dart.cn/samples#control-flow-statements
void flow_control(var year, var flybyObjects) {
  if (year >= 2001) {
    print('21th century');
  } else if (year >= 1901) {
    print('20th century');
  }
  for (final object in flybyObjects) {
    print(object);
  }
  for (int month = 1; month <= 12; month++) {
    print(month);
  }
  while (year < 2016) {
    year++;
  }
}

//函数  https://dart.cn/samples#functions
int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

//类  https://dart.cn/samples#classes
class Spacecraft {
  String name;
  DateTime? launchDate;
  //Read-only non-final property
  int? get launchYear => launchDate?.year;
  //Constructor, with syntactic sugar for assignment to members.
  Spacecraft(this.name, this.launchDate) {
    //Initialization code goes here.
  }
  //Named constructor that forwards to the default one.
  Spacecraft.unlaunched(String name) : this(name, null);
  //Method
  void describe() {
    print('Spacecraft:$name');
    //type promotion doesn't work on getters.
    var launchDate = this.launchDate;
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}

//扩展类 https://dart.cn/samples#inheritance
class Orbiter extends Spacecraft {
  double altitude;
  Orbiter(String name, DateTime launchDate, this.altitude)
      : super(name, launchDate);
}

void main(List<String> args) {
  //variables(); //变量
  //print(fibonacci(20)); //函数,斐波那契函数
  var voyager = Spacecraft('Voyager I', DateTime(1977, 9, 5));
  voyager.describe();

  var voyager3 = Spacecraft.unlaunched('Voyager III');
  voyager3.describe();
}
