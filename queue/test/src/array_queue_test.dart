// ignore_for_file: non_constant_identifier_names
import 'package:dartunit/dartunit.dart';
import 'package:queue/queue.dart';
import 'matchers.dart';

@TestCase()
@Root()
class ArrayQueueTest with ComposedExpect{  
  @override
  late final ArrayQueue<int> queue;   
}

@TestCase()
class GivenNewlyCreatedArrayQueueWith3Capacity extends ArrayQueueTest{
  
  late int x, y, z, w;

  @SetUp()
  void createNewArrauQueueWith3Capacity() {
    queue = ArrayQueue<int>(capacity: 3);
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
  void enqueue_ShouldEnqueueItemsInCorrectOrder(){
    _givenEnqueueXYZFollowdByOneDequeue();
    queue.enqueue(w);
    expect(queue.dequeue(), equals(y));
    expect(queue.dequeue(), equals(z));
   
  }

  @Test()
  void dequeue_ShouldDequeueItemsInCorrectOrder(){
    _givenEnqueueXYZFollowdByOneDequeue();
    queue.enqueue(w);
    expect(queue.dequeue(), equals(y));
    expect(queue.dequeue(), equals(z));
    expect(queue.dequeue(), equals(w));
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

  void _givenEnqueueXYZFollowdByOneDequeue() {
    queue.enqueue(x);
    queue.enqueue(y);
    queue.enqueue(z);
    queue.dequeue();
  }
}

@TestCase()
class NegativeCapasityArrayQueue extends ArrayQueueTest{

  @Test()
  void whenQueueWithNegativeCapacityIsCreated_ThenIllegalCapcityShouldBeThrown(){
    void act(){
      ArrayQueue(capacity: -1);
    }

    expect(act, throwsAIllegalCapcity);
  }
}

@TestCase()
class GivenZeroCapacityArrayQueue extends ArrayQueueTest{

  
  @SetUp()
  void createNewArrayQueueWithZeroCapacity() {
    queue = ArrayQueue<int>(capacity: 0);
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

  ArrayQueue<int> get queue;

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

