import 'dart:math';
import 'dart:convert';
import 'dart:math';
import 'dart:io' as IO;

// 数字、集合、字符串等（https://dart.cn/guides/libraries/library-tour#dartcore---numbers-collections-strings-and-more）
void dartcore_numbers_numbers_collections_strings_and_more() {
  assert(int.parse('42') == 42);
  assert(int.parse('0x42') == 66);
  assert(double.parse('0.50') == 0.5);
  assert(num.parse('42') is int);
  assert(num.parse('0x42') is int);
  assert(num.parse('0.50') is double);
  assert(int.parse('42', radix: 16) == 66);

  //使用 toString() 方法将整型或双精度浮点类型转换为字符串类型
  // Convert an int to a string.
  assert(42.toString() == '42');
  // Convert a double to a string.
  assert(123.456.toString() == '123.456');
  // Specify the number of digits after the decimal.
  assert(123.456.toStringAsFixed(2) == '123.46');
  // Specify the number of significant figures.
  assert(123.456.toStringAsPrecision(2) == '1.2e+2');
  assert(double.parse('1.2e+2') == 120.0);

  //在字符串内查找特定字符串的位置，以及检查字符串是否以特定字符串作为开头或结尾
  // Check whether a string contains another string.
  assert('Never odd or even'.contains('odd'));
  // Does a string start with another string?
  assert('Never odd or even'.startsWith('Never'));
  // Does a string end with another string?
  assert('Never odd or even'.endsWith('even'));
  // Find the location of a string inside a string.
  assert('Never odd or even'.indexOf('odd') == 6);

//从字符串中提取数据
  // Grab a substring.
  assert('Never odd or even'.substring(6, 9) == 'odd');
  // Split a string using a string pattern.
  var parts = 'progressive web apps'.split(' ');
  assert(parts.length == 3);
  assert(parts[0] == 'progressive');
  // Get a UTF-16 code unit (as a string) by index.
  assert('Never odd or even'[0] == 'N');
  // Use split() with an empty string parameter to get
  // a list of all characters (as Strings); good for
  // iterating.
  for (final char in 'hello'.split('')) {
    print(char);
  }
  // Get all the UTF-16 code units in the string.
  // UTF 编码（https://www.jianshu.com/p/ba7fb4a651c7）
  var codeUnitList = 'Never odd or even'.codeUnits.toList();
  assert(codeUnitList[0] == 78);

//首字母大小写转换
  // Convert to uppercase.
  assert('web apps'.toUpperCase() == 'WEB APPS');
  // Convert to lowercase.
  assert('WEB APPS'.toLowerCase() == 'web apps');

//Trimming 和空字符串
  // Trim a string.
  assert('  hello  '.trim() == 'hello');
// Check whether a string is empty.
  assert(''.isEmpty);
// Strings with only white space are not empty.
  assert('  '.isNotEmpty);

//替换部分字符串
  var greetingTemplate = 'Hello, NAME!';
  var greeting = greetingTemplate.replaceAll(RegExp('NAME'), 'Bob');

// greetingTemplate didn't change.
  assert(greeting != greetingTemplate);

  var sb = StringBuffer();
  sb
    ..write('Use a StringBuffer for ')
    ..writeAll(['efficient', 'string', 'creation'], ' ')
    ..write('.');
  // Cascade notation (https://stackoverflow.com/questions/49447736/list-use-of-double-dot-in-dart)

  var fullString = sb.toString();

  assert(fullString == 'Use a StringBuffer for efficient string creation.');

//构建一个字符串
  // Here's a regular expression for one or more digits.
  var numbers = RegExp(r'\d+');
  var allCharacters = 'llamas live fifteen to twenty years';
  var someDigits = 'llamas live 15 to 20 years';
// contains() can use a regular expression.
  assert(!allCharacters.contains(numbers));
  assert(someDigits.contains(numbers));
}

// 集合 (https://dart.cn/guides/libraries/library-tour#collections)
void the_lists() {
  // Create an empty list of strings.
  var grains = <String>[];
  assert(grains.isEmpty);

// Create a list using a list literal.
  var fruits = ['apples', 'oranges'];

// Add to a list.
  fruits.add('kiwis');

// Add multiple items to a list.
  fruits.addAll(['grapes', 'bananas']);

// Get the list length.
  assert(fruits.length == 5);

// Remove a single item.
  var appleIndex = fruits.indexOf('apples');
  fruits.removeAt(appleIndex);
  assert(fruits.length == 4);

// Remove all elements from a list.
  fruits.clear();
  assert(fruits.isEmpty);

// You can also create a List using one of the constructors.
  var vegetables = List.filled(99, 'broccoli');
  assert(vegetables.every((v) => v == 'broccoli'));

  fruits = ['bananas', 'apples', 'oranges'];

// Sort a list.
  fruits.sort((a, b) => a.compareTo(b));
  assert(fruits[0] == 'apples');

  fruits = <String>[];

  fruits.add('apples');
  var fruit = fruits[0];
  assert(fruit is String);
  // Error: 'int' can't be assigned to 'String'
  // fruits.add(5);
}

void the_sets() {
  // Create an empty set of strings.
  var ingredients = <String>{};

// Add new items to it.
  ingredients.addAll(['gold', 'titanium', 'xenon']);
  assert(ingredients.length == 3);

// Adding a duplicate item has no effect.
  ingredients.add('gold');
  assert(ingredients.length == 3);

// Remove an item from a set.
  ingredients.remove('gold');
  assert(ingredients.length == 2);

// You can also create sets using
// one of the constructors.
  var atomicNumbers = Set.from([79, 22, 54]);
  assert(atomicNumbers.length == 3);

  ingredients = Set<String>();
  ingredients.addAll(['gold', 'titanium', 'xenon']);

// Check whether an item is in the set.
  assert(ingredients.contains('titanium'));

// Check whether all the items are in the set.
  assert(ingredients.containsAll(['titanium', 'xenon']));

  ingredients = Set<String>();
  ingredients.addAll(['gold', 'titanium', 'xenon']);

// Create the intersection of two sets.
  var nobleGases = Set.from(['xenon', 'argon']);
  var intersection = ingredients.intersection(nobleGases);
  assert(intersection.length == 1);
  assert(intersection.contains('xenon'));
}

void the_maps() {
  // Maps often use strings as keys.
  var hawaiianBeaches = {
    'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
    'Big Island': ['Wailea Bay', 'Pololu Beach'],
    'Kauai': ['Hanalei', 'Poipu']
  };

// Maps can be built from a constructor.
  var searchTerms = Map();

// Maps are parameterized types; you can specify what
// types the key and value should be.
  var nobleGases = Map<int, String>();

  nobleGases = {54: 'xenon'}; // 惰性气体

// Retrieve a value with a key.
  assert(nobleGases[54] == 'xenon');

// Check whether a map contains a key.
  assert(nobleGases.containsKey(54));

// Remove a key and its value.
  nobleGases.remove(54);
  assert(!nobleGases.containsKey(54));

  hawaiianBeaches = {
    'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
    'Big Island': ['Wailea Bay', 'Pololu Beach'],
    'Kauai': ['Hanalei', 'Poipu']
  };

// Get all the keys as an unordered collection
// (an Iterable).
  var keys = hawaiianBeaches.keys;

  assert(keys.length == 3);
  assert(Set.from(keys).contains('Oahu'));

// Get all the values as an unordered collection
// (an Iterable of Lists).
  var values = hawaiianBeaches.values;
  assert(values.length == 3);
  assert(values.any((v) => v.contains('Waikiki')));
  // any （https://blog.csdn.net/qq_42351033/article/details/108161475）

  hawaiianBeaches = {
    'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
    'Big Island': ['Wailea Bay', 'Pololu Beach'],
    'Kauai': ['Hanalei', 'Poipu']
  };

  assert(hawaiianBeaches.containsKey('Oahu'));
  assert(!hawaiianBeaches.containsKey('Florida'));

  var teamAssignments = <String, String>{};
  String pickToughestKid() {
    return "pickToughestKid";
  }

  teamAssignments.putIfAbsent('Catcher', () => pickToughestKid());
  assert(teamAssignments['Catcher'] != null);
}

void the_public_methods() {
  var coffees = <String>[];
  var teas = ['green', 'black', 'chamomile', 'earl grey'];
  assert(coffees.isEmpty);
  assert(teas.isNotEmpty);

  teas = ['green', 'black', 'chamomile', 'earl grey'];
  teas.forEach((tea) => print('I drink $tea'));

  var hawaiianBeaches = {
    'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
    'Big Island': ['Wailea Bay', 'Pololu Beach'],
    'Kauai': ['Hanalei', 'Poipu']
  };
  hawaiianBeaches.forEach((k, v) {
    print('I want to visit $k and swim at $v');
    // I want to visit Oahu and swim at
    // [Waikiki, Kailua, Waimanalo], etc.
  });

  teas = ['green', 'black', 'chamomile', 'earl grey'];

  var loudTeas = teas.map((tea) => tea.toUpperCase());
  loudTeas.forEach(print);
  var loadTeas_str = loudTeas = teas.map((tea) => tea.toUpperCase()).toList();
  print(loadTeas_str);

  teas = ['green', 'black', 'chamomile', 'earl grey'];

// Chamomile is not caffeinated.
  bool isDecaffeinated(String teaName) => teaName == 'chamomile';

// Use where() to find only the items that return true
// from the provided function.
  var decaffeinatedTeas = teas.where((tea) => isDecaffeinated(tea));
// or teas.where(isDecaffeinated)

// Use any() to check whether at least one item in the
// collection satisfies a condition.
  assert(teas.any(isDecaffeinated));

// Use every() to check whether all the items in a
// collection satisfy a condition.
  assert(!teas.every(isDecaffeinated));
}

void collections() {
  print('\n');
  print('#' * 40);
  print('集合');
  print('#' * 40);

  the_lists();
  the_sets();
  the_maps();
  the_public_methods();
}

// URIs (https://dart.cn/guides/libraries/library-tour#uris)
void URIs() {
  var uri = 'https://example.org/api?foo=some message';

  var encoded = Uri.encodeFull(uri);
  assert(encoded == 'https://example.org/api?foo=some%20message');
  var decoded = Uri.decodeFull(encoded);
  assert(uri == decoded);
  decoded = Uri.decodeComponent(encoded);
  assert(uri == decoded);
  print("uri=${uri.toString()}");

  var uri1 = Uri.parse('https://example.org:8080/foo/bar#frag');
  assert(uri1.scheme == 'https');
  assert(uri1.host == 'example.org');
  assert(uri1.path == '/foo/bar');
  assert(uri1.fragment == 'frag');
  assert(uri1.origin == 'https://example.org:8080');
  print("uri1=${uri1.toString()}");

  var uri2 = Uri(
      scheme: 'https', host: 'example.org', path: '/foo/bar', fragment: 'frag');
  assert(uri2.toString() == 'https://example.org/foo/bar#frag');
  print("uri2=${uri2.toString()}");
}

// 时间和日期 （https://dart.cn/guides/libraries/library-tour#dates-and-times）
void dates_and_times() {
  print('\n');
  print('#' * 40);
  print('时间和日期');
  print('#' * 40);

  // Get the current date and time.
  var now = DateTime.now();

// Create a new DateTime with the local time zone.
  var y2k = DateTime(2000); // January 1, 2000

// Specify the month and day.
  y2k = DateTime(2000, 1, 2); // January 2, 2000

// Specify the date as a UTC time.
  y2k = DateTime.utc(2000); // 1/1/2000, UTC

// Specify a date and time in ms since the Unix epoch.
  y2k = DateTime.fromMillisecondsSinceEpoch(946684800000, isUtc: true);

// Parse an ISO 8601 date.
  y2k = DateTime.parse('2000-01-01T00:00:00Z');

  // 1/1/2000, UTC
  y2k = DateTime.utc(2000);
  assert(y2k.millisecondsSinceEpoch == 946684800000);

// 1/1/1970, UTC
  var unixEpoch = DateTime.utc(1970);
  assert(unixEpoch.millisecondsSinceEpoch == 0);

  y2k = DateTime.utc(2000);

// Add one year.
  var y2001 = y2k.add(const Duration(days: 366));
  assert(y2001.year == 2001);

// Subtract 30 days.
  var december2000 = y2001.subtract(const Duration(days: 30));
  assert(december2000.year == 2000);
  assert(december2000.month == 12);

// Calculate the difference between two dates.
// Returns a Duration object.
  var duration = y2001.difference(y2k);
  assert(duration.inDays == 366); // y2k was a leap year.
}

// 工具类 （https://dart.cn/guides/libraries/library-tour#utility-classes）
//比较对象
class Line implements Comparable<Line> {
  final int length;
  const Line(this.length);

  @override
  int compareTo(Line other) => length - other.length;
}

//Implementing map keys
class Person {
  final String firstName, lastName;

  Person(this.firstName, this.lastName);

  // Override hashCode using the static hashing methods
  // provided by the `Object` class.
  @override
  int get hashCode => Object.hash(firstName, lastName);

  // You should generally implement operator `==` if you
  // override `hashCode`.
  @override
  bool operator ==(dynamic other) {
    return other is Person &&
        other.firstName == firstName &&
        other.lastName == lastName;
  }
}

// 异常 (https://dart.cn/guides/libraries/library-tour#exceptions)
class FooException implements Exception {
  final String? msg;

  const FooException([this.msg]);

  @override
  String toString() => msg ?? 'FooException';
}

// 数学和随机数 （https://dart.cn/guides/libraries/library-tour#dartmath---math-and-random）
void math_and_random() {
  print('\n');
  print('#' * 40);
  print('数学和随机数');
  print('#' * 40);

  // Cosine
  assert(cos(pi) == -1.0);

// Sine
  var degrees = 30;
  var radians = degrees * (pi / 180);
// radians is now 0.52359.
  var sinOf30degrees = sin(radians);
// sin 30° = 0.5
  assert((sinOf30degrees - 0.5).abs() < 0.01);

  assert(max(1, 1000) == 1000);
  assert(min(1, -1000) == -1000);

  // See the Math library for additional constants.
  print(e); // 2.718281828459045
  print(pi); // 3.141592653589793
  print(sqrt2); // 1.4142135623730951

  var random = Random();
  var value1 = random.nextDouble(); // Between 0.0 and 1.0: [0, 1)
  print('nextDouble: $value1');
  var value2 = random.nextInt(10); // Between 0 and 9.
  print('nextInt: $value2');
  var value3 = random.nextBool(); // true or false
  print('nextBool: $value3');
}

// 编解码JSON，UTF-8等 (https://dart.cn/guides/libraries/library-tour#dartconvert---decoding-and-encoding-json-utf-8-and-more)
void Encoding_decoding() {
//使用 jsonDecode() 解码 JSON 编码的字符串为 Dart 对象：
// NOTE: Be sure to use double quotes ("),
// not single quotes ('), inside the JSON string.
// This string is JSON, not Dart.
  var jsonString = ''' [
    {"score": 40},
    {"score": 80}
  ]
''';
  var scores = jsonDecode(jsonString); //jsonDecode() 解码 JSON 编码的字符串为 Dart 对象
  assert(scores is List); //scores为列表
  var firstScore = scores[0];
  assert(firstScore is Map); //firstScore为哈希表
  assert(firstScore['score'] == 40); //'score'对应为40
  firstScore = scores[1];
  assert(firstScore['score'] == 80); //'score'对应为80
//使用 jsonEncode() 编码 Dart 对象为 JSON 格式的字符串：
  scores = [
    //scores为表
    {'score': 40},
    {'score': 80},
    {'score': 100, 'overtime': true, 'special_guest': null}
  ];

  var jsonText = jsonEncode(scores); //将scores转化为字符串存入jsonText
  assert(jsonText ==
      '[{"score":40},{"score":80},'
          '{"score":100,"overtime":true,'
          '"special_guest":null}]'); //jsonText为字符串

//使用 utf8.decode() 解码 UTF8 编码的字符创为 Dart 字符串：
  List<int> utf8Bytes = [
    0xc3,
    0x8e,
    0xc3,
    0xb1,
    0xc5,
    0xa3,
    0xc3,
    0xa9,
    0x72,
    0xc3,
    0xb1,
    0xc3,
    0xa5,
    0xc5,
    0xa3,
    0xc3,
    0xae,
    0xc3,
    0xb6,
    0xc3,
    0xb1,
    0xc3,
    0xa5,
    0xc4,
    0xbc,
    0xc3,
    0xae,
    0xc5,
    0xbe,
    0xc3,
    0xa5,
    0xc5,
    0xa3,
    0xc3,
    0xae,
    0xe1,
    0xbb,
    0x9d,
    0xc3,
    0xb1
  ];

  var funnyWord = utf8.decode(utf8Bytes);

  assert(funnyWord == 'Îñţérñåţîöñåļîžåţîờñ');

//使用 utf8.encode() 将 Dart 字符串编码为一个 UTF8 编码的字节流：
  List<int> encoded = utf8.encode('Îñţérñåţîöñåļîžåţîờñ');

  assert(encoded.length == utf8Bytes.length);
  for (int i = 0; i < encoded.length; i++) {
    assert(encoded[i] == utf8Bytes[i]);
  }
}

// 服务器和命令行应用程序的 I/O（https://dart.cn/guides/libraries/library-tour#dartio）
void IO_example() async {
  var config = IO.File('02_test.txt');
  // Put the whole file in a single string.
  var stringContents = await config.readAsString();
  print('The file is ${stringContents.length} characters long.');

  // Put each line of the file into its own string.
  var lines = await config.readAsLines();
  print('The file is ${lines.length} lines long.');
}

void main(List<String> args) {
  // 数字、集合、字符串等
  print("数字、集合、字符串：");
  dartcore_numbers_numbers_collections_strings_and_more();

  // 集合
  print("\n集合：");
  collections();
  //URIS
  print("\nURIS：");
  URIs();
  // 时间和日期
  print("\n时间和日期：");
  dates_and_times();

  // 数学和随机数
  math_and_random();
  print("\nIO：");
  IO_example();
  print('done.');
}
