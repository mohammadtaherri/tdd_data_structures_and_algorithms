import 'package:test/test.dart';
import 'package:queue/queue.dart';


var throwsAFullQueue = throwsA(isA<FullQueueException>());
var throwsAEmptyQueue = throwsA(isA<EmptyQueueException>());
var throwsAIllegalCapcity = throwsA(isA<IllegalCapcityException>());