import 'package:dartunit/dartunit.dart';

import 'package:queue/queue.dart';

void main() {
  runTestsByLibraryPath('src/array_queue_test.dart');
  runTestsByLibraryPath('src/linked_list_queue_test.dart');
  runTestsByLibraryPath('src/stack_queue_test.dart');
}

abstract class QueueTest with ComposedExpect{}

mixin ComposedExpect{

  Queue<int> get queue;

  void expectQueueIsEmpty(){
    expect(queue.isEmpty, isTrue);
    expect(queue.size, isZero);
  }

  void expectQueueSizeIsOne(){
    expect(queue.isEmpty, isFalse);
    expect(queue.size, equals(1));
  }

  void expectQueueSizeIsTwo(){
    expect(queue.isEmpty, isFalse);
    expect(queue.size, equals(2));
  }

  void expectQueueIsNotFull(){
    expect(queue.isFull, isFalse);
  }
}


