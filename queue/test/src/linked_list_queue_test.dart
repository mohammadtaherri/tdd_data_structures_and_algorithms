// ignore_for_file: non_constant_identifier_names

library linked_list_queue_test;

import 'package:dartunit/dartunit.dart';

import 'package:queue/queue.dart';
import './matchers.dart';

@TestCase()
@Root()
class LinkedListQueueTest with ComposedExpect{  
  @override
  late final LinkedListQueue<int> queue;   
}

@TestCase()
class GivenNewlyCreatedLinkedListQueueWith3Capacity extends LinkedListQueueTest{
  
  late int x, y, z, w;

  @SetUp()
  void createNewLinkedListQueueWith3Capacity() {
    queue = LinkedListQueue<int>(capacity: 3);
    x = 10;
    y = 20;
    z = 30;
    w = 40;
  }

  @Test()
  void shouldBeEmpty(){
    expectQueueIsEmpty();
  }

  @Test()
  void shouldNotBeFull(){
    expectQueueIsNotFull();
  }

  @Test()
  void enqueue_ShouldIncrementSizebyOne(){
    queue.enqueue(x);
    expectQueueSizeIsOne();

    queue.enqueue(x);
    expectQueueSizeIsTwo();
  }

  @Test()
  void dequeue_ShouldDecrementSizeByOne(){
    queue.enqueue(x);
    queue.enqueue(x);

    queue.dequeue();
    expectQueueSizeIsOne();

    queue.dequeue();
    expectQueueIsEmpty();
  }

  @Test()
  void enqueue_WhenPastCapacity_ShouldThrowFullQueue(){
    void act(){
      queue.enqueue(x);
      queue.enqueue(x);
      queue.enqueue(x);
      queue.enqueue(x);
    }

    expect(act, throwsAFullQueue);
  }

  @Test()
  void dequeue_ShouldThrowEmptyQueue(){
    void act(){
      queue.dequeue();
    }

    expect(act, throwsAEmptyQueue);
  }

  @Test()
  void peek_ShouldThrowEmptyQueue(){
    void act(){
      queue.peek();
    }

    expect(act, throwsAEmptyQueue);
  }

  @Test()
  void enqueue_dequeue_WhenXIsEnqueued_XShouldBeDequeued(){
    queue.enqueue(x);
    expect(queue.dequeue(), equals(x));
  }

  @Test()
  void enqueue_dequeue_WhenXAndYAreEnqueued_XAndYShouldBeDequeued(){
    queue.enqueue(x);
    queue.enqueue(y);
    expect(queue.dequeue(), equals(x));
    expect(queue.dequeue(), equals(y));
  }

  @Test()
  void peek_GivenEnqueuingX_ShouldReturnX(){
    queue.enqueue(x);
    expect(queue.peek(), equals(x));
  }

  @Test()
  void peek_GivenEnqueuingXAndY_ShouldReturnX(){
    queue.enqueue(x);
    queue.enqueue(y);
    expect(queue.peek(), equals(x));
  }
}

@TestCase()
class NegativeCapasityArrayQueue extends LinkedListQueueTest{

  @Test()
  void whenQueueWithNegativeCapacityIsCreated_ThenIllegalCapcityShouldBeThrown(){
    void act(){
      LinkedListQueue(capacity: -1);
    }

    expect(act, throwsAIllegalCapcity);
  }
}

@TestCase()
class GivenZeroCapacityArrayQueue extends LinkedListQueueTest{

  
  @SetUp()
  void createNeLinkedListQueueWithZeroCapacity() {
    queue = LinkedListQueue<int>(capacity: 0);
  }

  @Test()
  void shouldBeEmpty(){
    expectQueueIsEmpty();
  }

  @Test()
  void shouldBeFull(){
    expect(queue.isFull, isTrue);
  }

  @Test()
  void enqueue_ShouldThrowFullQueue(){
    void act(){
      queue.enqueue(10);
    }

    expect(act, throwsAFullQueue);
  }

  @Test()
  void dequeue_ShouldThrowEmptyQueue(){
    void act(){
      queue.dequeue();
    }

    expect(act, throwsAEmptyQueue);
  }

  @Test()
  void peek_ShouldThrowEmptyQueue(){
    void act(){
      queue.peek();
    }

    expect(act, throwsAEmptyQueue);
  }
}


mixin ComposedExpect{

  LinkedListQueue<int> get queue;

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

