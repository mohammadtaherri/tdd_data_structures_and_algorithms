import 'package:test/test.dart';
import 'package:linked_list/linked_list.dart';

var throwsAIllegalState = throwsA(isA<IllegalState>());
var throwsAEmpty = throwsA(isA<Empty>());
var throwsAOutOfRange = throwsA(isA<OutOFRange>());