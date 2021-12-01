import 'package:flutter_test/flutter_test.dart';
import 'package:kayta_flutter/Shared/Errors/Failure.dart';

main() {
  test("Failure toString Test", () async {
    var failure = GenericFailure();
    expect(failure, isA<Failure>());
    expect(failure.toString(), "GenericFailure Exception");
  });

  test("MessageFailure Test", () async {
    var failure = MessageFailure("Some Error");
    expect(failure, isA<Failure>());
    expect(failure.toString(), "MessageFailure Exception");
    expect("Some Error", failure.mensagem);
  });
}
