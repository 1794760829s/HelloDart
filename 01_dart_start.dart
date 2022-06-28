// Importing core libraries
import 'dart:math';
import 'dart:io';

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
  print("\n");
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
    stdout.write("${object}  ");
  }
  print("\n");
  for (int month = 1; month <= 12; month++) {
    stdout.write("${month}  ");
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

//Mixins https://dart.cn/samples#mixins
mixin Piloted {
  int astronauts = 1;

  void describeCrew() {
    print('Number of astronauts: $astronauts');
  }
}

class PilotedCraft extends Spacecraft with Piloted {
  PilotedCraft(String name, DateTime launchDate) : super(name, launchDate);
}

//抽象类https://dart.cn/samples#interfaces-and-abstract-classes
abstract class Describable {
  void describe();

  void describeWithEmphasis();
}

class Des implements Describable {
  var str = '抽象类';
  @override
  void describe() {
    print(str);
  }

  @override
  void describeWithEmphasis() {
    print('=========');
    describe();
    print('=========');
  }
}

//异步与异常 https://dart.cn/samples#async;
//          https:dart.cn/samples#exceptions
Future<void> createDescriptions(Iterable<String> objects) async {
  for (final object in objects) {
    try {
      var file = new File('$object.txt');
      if (await file.exists()) {
        var modified = await file.lastModified();
        print('File for $object already exists. It was modified on $modified.');
        continue;
      }
      await file.create();
      await file.writeAsString('Start describing $object in this file.');
    } on IOException catch (e) {
      print('Cannot create description for $object: $e');
    }
  }
}

void main(List<String> args) {
  print("变量：");
  variables(); //变量

  print("斐波那契数列的第20个数：${fibonacci(20)}\n"); //函数,斐波那契函数

  print("类：");
  var voyager = Spacecraft('Voyager I', DateTime(1977, 9, 5));
  voyager.describe();
  var voyage2 = Spacecraft.unlaunched('Voyager III');
  voyage2.describe();
  var voyager3 = Orbiter('Voyager III', DateTime(1980, 10, 12), 3);
  voyager3.describe();
  var voyager4 = PilotedCraft('Voyager Ⅳ', DateTime(1985, 5, 14));
  voyager4.describe();
  voyager4.describeCrew();

  Des().describeWithEmphasis();
  Iterable<String> test = ['01_test'];
  createDescriptions(test);
}
