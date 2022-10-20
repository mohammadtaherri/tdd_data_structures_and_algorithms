// ignore_for_file: non_constant_identifier_names

import 'package:test/test.dart';
import 'package:clean_test/clean_test.dart';
import 'package:queue/queue.dart';

import 'matchers.dart';

void main() {
  runTest(ArrayQueueTest());
}

class ArrayQueueTest extends RootTestGroup{
  ArrayQueueTest()
      : super(
        groups: [
          GivenNewlyCreatedArrayQueueWithPositiveCapacity(),
          NegativeCapasityArrayQueue(),
          GivenZeroCapacityArrayQueue(),
        ],
      );
}

class GivenNewlyCreatedArrayQueueWithPositiveCapacity extends LeafTestGroup with ComposedExpect{

  @override
  late ArrayQueue<int> queue;

  @override
  void setUp() {
    queue = ArrayQueue<int>(capacity: 3);
  }

  void shouldBeEmpty(){
    expectQueueIsEmpty();
  }

  void shouldNotBeFull(){
    expectQueueIsNotFull();
  }

  void enqueue_ShouldIncrementSizebyOne(){
    queue.enqueue(10);
    expectQueueSizeIsOne();

    queue.enqueue(10);
    expectQueueSizeIsTwo();
  }

  void dequeue_ShouldDecrementSizeByOne(){
    queue.enqueue(10);
    queue.enqueue(10);

    queue.dequeue();
    expectQueueSizeIsOne();

    queue.dequeue();
    expectQueueIsEmpty();
  }

  void enqueue_WhenPastCapacity_ShouldThrowFullQueue(){
    void act(){
      queue.enqueue(10);
      queue.enqueue(10);
      queue.enqueue(10);
      queue.enqueue(10);
    }

    expect(act, throwsAFullQueue);
  }

  void dequeue_ShouldThrowEmptyQueue(){
    void act(){
      queue.dequeue();
    }

    expect(act, throwsAEmptyQueue);
  }

  void peek_ShouldThrowEmptyQueue(){
    void act(){
      queue.peek();
    }

    expect(act, throwsAEmptyQueue);
  }

  void enqueue_dequeue_WhenXIsEnqueued_XShouldBeDequeued(){
    final x = 10;
    queue.enqueue(x);
    expect(queue.dequeue(), equals(x));
  }

  void enqueue_dequeue_WhenXAndYAreEnqueued_XAndYShouldBeDequeued(){
    final x = 10;
    final y = 20;
    queue.enqueue(x);
    queue.enqueue(y);
    expect(queue.dequeue(), equals(x));
    expect(queue.dequeue(), equals(y));
  }

  void enqueue_ShouldBeCircular(){
    final x = 10;
    final y = 20;
    final z = 30;
    final q = 40;

    queue.enqueue(x);
    queue.enqueue(y);
    queue.enqueue(z);

    queue.dequeue();

    queue.enqueue(q);

    expect(queue.dequeue(), equals(y));
    expect(queue.dequeue(), equals(z));
   
  }

  void dequeue_ShouldBeCircular(){
    final x = 10;
    final y = 20;
    final z = 30;
    final q = 40;

    queue.enqueue(x);
    queue.enqueue(y);
    queue.enqueue(z);

    queue.dequeue();

    queue.enqueue(q);

    expect(queue.dequeue(), equals(y));
    expect(queue.dequeue(), equals(z));
    expect(queue.dequeue(), equals(q));
  }

  void peek_GivenEnqueuingX_ShouldReturnX(){
    final x = 10;
    queue.enqueue(x);
    expect(queue.peek(), equals(x));
  }

  void peek_GivenEnqueuingXAndY_ShouldReturnX(){
    final x = 10;
    final y = 20;
    queue.enqueue(x);
    queue.enqueue(y);
    expect(queue.peek(), equals(x));
  }

  @override
  void registerTests(TestContainer container) {
    container.addAll([
      Test(shouldBeEmpty),
      Test(shouldNotBeFull),
      Test(enqueue_ShouldIncrementSizebyOne),
      Test(dequeue_ShouldDecrementSizeByOne),
      Test(enqueue_WhenPastCapacity_ShouldThrowFullQueue),
      Test(dequeue_ShouldThrowEmptyQueue),
      Test(peek_ShouldThrowEmptyQueue),
      Test(enqueue_dequeue_WhenXIsEnqueued_XShouldBeDequeued),
      Test(enqueue_dequeue_WhenXAndYAreEnqueued_XAndYShouldBeDequeued),
      Test(enqueue_ShouldBeCircular),
      Test(dequeue_ShouldBeCircular),
      Test(peek_GivenEnqueuingX_ShouldReturnX),
      Test(peek_GivenEnqueuingXAndY_ShouldReturnX),
    ]);
  }
}

class NegativeCapasityArrayQueue extends LeafTestGroup{

  void whenQueueWithNegativeCapacityIsCreated_ThenIllegalCapcityShouldBeThrown(){
    void act(){
      ArrayQueue(capacity: -1);
    }

    expect(act, throwsAIllegalCapcity);
  }

  @override
  void registerTests(TestContainer container) {
    container.addAll([
      Test(whenQueueWithNegativeCapacityIsCreated_ThenIllegalCapcityShouldBeThrown),
    ]);
  }
}

class GivenZeroCapacityArrayQueue extends LeafTestGroup with ComposedExpect{

  @override
  late ArrayQueue<int> queue;

  @override
  void setUp() {
    queue = ArrayQueue<int>(capacity: 0);
  }

  void shouldBeEmpty(){
    expectQueueIsEmpty();
  }

  void shouldBeFull(){
    expect(queue.isFull, isTrue);
  }

  void enqueue_ShouldThrowFullQueue(){
    void act(){
      queue.enqueue(10);
    }

    expect(act, throwsAFullQueue);
  }

  void dequeue_ShouldThrowEmptyQueue(){
    void act(){
      queue.dequeue();
    }

    expect(act, throwsAEmptyQueue);
  }

  void peek_ShouldThrowEmptyQueue(){
    void act(){
      queue.peek();
    }

    expect(act, throwsAEmptyQueue);
  }

  @override
  void registerTests(TestContainer container) {
    container.addAll([
      Test(shouldBeEmpty),
      Test(shouldBeFull),
      Test(enqueue_ShouldThrowFullQueue),
      Test(dequeue_ShouldThrowEmptyQueue),
      Test(peek_ShouldThrowEmptyQueue),
    ]);
  }
}

mixin ComposedExpect on TestGroup{

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

