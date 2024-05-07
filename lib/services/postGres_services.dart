import 'package:postgres/postgres.dart';

late final connection;
Object? particpiantIDfromPost;
Object? teamName;

Future<void> connectWithPost() async {
  print('in connection function');
   connection = await Connection.open(
    Endpoint(
      host: ,
      database: ,
      username: ,
      password: ,
      port: ,
    ),
    settings: const ConnectionSettings(sslMode: SslMode.require),
  );
  print('has connection!');
}

Future<String> sendCodeToPost(String code) async {
  print('in send code');
  print(code);
  
  final result = await connection.execute(
    Sql.named('SELECT id_card FROM public.hashes WHERE "hash" = @code'),
    parameters: {'code': code},
  );
  print(result[0][0]);
  print('code sent');
  return result[0][0];
}

Future<void> markAttendance1(String code) async {
  final connection = await Connection.open(
    Endpoint(
      host: ,
      database: ,
      username: ,
      password: ,
      port: ,
    ),
    settings: const ConnectionSettings(sslMode: SslMode.require),
  );
  
  final idResult = await connection.execute(
    Sql.named('SELECT participantid FROM public.hashes WHERE "hash" = @code'),
    parameters: {'code': code},
  );

  final participantId = idResult[0][0];
  particpiantIDfromPost = participantId;
  print("object");
  print(particpiantIDfromPost);

  final team = await connection.execute(
    Sql.named('SELECT "teamname" FROM public.team_identifier WHERE "Enrollment No. (Team-Leader)" = ( SELECT "Enrollment No. (Team-Leader)" FROM public.participant_attendance WHERE "Participant_Id" = @x);'),
    parameters: {'x': participantId},
  );

  final teamname = team[0][0];
  teamName = teamname;
  print("team");
  print(teamName);


  await connection.execute(
    Sql.named('UPDATE public.participant_attendance SET attendance_1 = True WHERE "Participant_Id" = @x'),
    parameters: {'x': participantId},
  );
}

Future<void> markAttendance2(String code) async {
  final connection = await Connection.open(
    Endpoint(
      host: ,
      database: ,
      username: ,
      password: ,
      port: ,
    ),
    settings: const ConnectionSettings(sslMode: SslMode.require),
  );
  final idResult = await connection.execute(
    Sql.named('SELECT participantid FROM public.hashes WHERE "hash" = @code'),
    parameters: {'code': code},
  );

  final participantId = idResult[0][0];
  particpiantIDfromPost = participantId;
  print("object");
  print(particpiantIDfromPost);

  final team = await connection.execute(
    Sql.named('SELECT "teamname" FROM public.team_identifier WHERE "Enrollment No. (Team-Leader)" = ( SELECT "Enrollment No. (Team-Leader)" FROM public.participant_attendance WHERE "Participant_Id" = @x);'),
    parameters: {'x': participantId},
  );

  final teamname = team[0][0];
  teamName = teamname;
  print("team");
  print(teamName);

  await connection.execute(
    Sql.named('UPDATE public.participant_attendance SET attendance_2 = True WHERE "Participant_Id" = @x'),
    parameters: {'x': participantId},
  );

}

Future<Object?> markAttendance3(String code) async {
  final connection = await Connection.open(
    Endpoint(
      host: ,
      database: ,
      username: ,
      password: ,
      port: ,
    ),
    settings: const ConnectionSettings(sslMode: SslMode.require),
  );
  final idResult = await connection.execute(
    Sql.named('SELECT participantid FROM public.hashes WHERE "hash" = @code'),
    parameters: {'code': code},
  );

  final participantId = idResult[0][0];
  particpiantIDfromPost = participantId;
  print("object");
  print(particpiantIDfromPost);

  final team = await connection.execute(
    Sql.named('SELECT "teamname" FROM public.team_identifier WHERE "Enrollment No. (Team-Leader)" = ( SELECT "Enrollment No. (Team-Leader)" FROM public.participant_attendance WHERE "Participant_Id" = @x);'),
    parameters: {'x': participantId},
  );

  final teamname = team[0][0];
  teamName = teamname;
  print("team");
  print(teamName);

  await connection.execute(
    Sql.named('UPDATE public.participant_attendance SET attendance_3 = True WHERE "Participant_Id" = @x'),
    parameters: {'x': participantId},
  );

  return participantId;
}
