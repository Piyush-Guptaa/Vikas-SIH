final String tableVikass = 'vikass';

class VikasFields {
  static final List<String> values = [
    id,
    time,
    name,
    age,
    shgname,
    aadharnumber,
    monthlyincome,
    bankname,
    bankaccountnumber,
    shgid
  ];

  static final String id = '_id';
  static final String time = 'date';
  static final String name = 'name';
  static final String age = 'age';
  static final String shgname = 'shgname';
  static final String aadharnumber = 'aadharnumber';
  static final String monthlyincome = 'monthlyincome';
  static final String bankname = 'bankname';
  static final String bankaccountnumber = 'bankaccountnumber';
  static final String shgid = 'shgid';
}

class Vikas {
  final int? id;
  final DateTime createdTime;
  final String name;
  final String age;
  final String shgname;
  final String aadharnumber;
  final String monthlyincome;
  final String bankname;
  final String bankaccountnumber;
  final String shgid;

  const Vikas({
    this.id,
    required this.createdTime,
    required this.name,
    required this.age,
    required this.shgname,
    required this.aadharnumber,
    required this.monthlyincome,
    required this.bankname,
    required this.bankaccountnumber,
    required this.shgid,
  });

  Vikas copy({
    int? id,
    DateTime? createdTime,
    String? name,
    String? age,
    String? shgname,
    String? aadharnumber,
    String? monthlyincome,
    String? bankname,
    String? bankaccountnumber,
    String? shgid,
  }) =>
      Vikas(
        id: id ?? this.id,
        createdTime: createdTime ?? this.createdTime,
        name: name ?? this.name,
        age: age ?? this.age,
        shgname: shgname ?? this.shgname,
        aadharnumber: aadharnumber ?? this.aadharnumber,
        monthlyincome: monthlyincome ?? this.monthlyincome,
        bankname: bankname ?? this.bankname,
        bankaccountnumber: bankaccountnumber ?? this.bankaccountnumber,
        shgid: shgid ?? this.shgid,
      );

  static Vikas fromJson(Map<String, Object?> json) => Vikas(
        id: json[VikasFields.id] as int?,
        createdTime: DateTime.parse(json[VikasFields.time] as String),
        name: json[VikasFields.name] as String,
        age: json[VikasFields.age] as String,
        shgname: json[VikasFields.shgname] as String,
        aadharnumber: json[VikasFields.aadharnumber] as String,
        monthlyincome: json[VikasFields.monthlyincome] as String,
        bankname: json[VikasFields.bankname] as String,
        bankaccountnumber: json[VikasFields.bankaccountnumber] as String,
        shgid: json[VikasFields.shgid] as String,
      );

  Map<String, Object?> toJson() => {
        VikasFields.id: id,
        VikasFields.time: createdTime.toIso8601String(),
        VikasFields.name: name,
        VikasFields.age: age,
        VikasFields.shgname: shgname,
        VikasFields.aadharnumber: aadharnumber,
        VikasFields.monthlyincome: monthlyincome,
        VikasFields.bankname: bankname,
        VikasFields.bankaccountnumber: bankaccountnumber,
        VikasFields.shgid: shgid,
      };
}
