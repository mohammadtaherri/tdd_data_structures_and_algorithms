import 'package:test/test.dart';
import 'package:linked_list_composition/linked_list.dart';

var throwsAIllegalState = throwsA(isA<IllegalState>());
var throwsAEmpty = throwsA(isA<Empty>());
var throwsAOutOfRange = throwsA(isA<OutOFRange>());