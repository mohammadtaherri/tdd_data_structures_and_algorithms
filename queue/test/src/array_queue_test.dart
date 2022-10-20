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
          GivenNewlyCreatedArrayQueueWith3Capacity(),
          NegativeCapasityArrayQueue(),
          GivenZeroCapacityArrayQueue(),
        ],
      );
}

class GivenNewlyCreatedArrayQueueWith3Capacity extends LeafTestGroup with ComposedExpect{

  @override
  late ArrayQueue<int> queue;
  late int x, y, z, w;

  @override
  void setUp() {
    queue = ArrayQueue<int>(capacity: 3);
    x = 10;
    y = 20;
    z = 30;
    w = 40;
  }

  void shouldBeEmpty(){
    expectQueueIsEmpty();
  }

  void shouldNotBeFull(){
    expectQueueIsNotFull();
  }

  void enqueue_ShouldIncrementSizebyOne(){
    queue.enqueue(x);
    expectQueueSizeIsOne();

    queue.enqueue(x);
    expectQueueSizeIsTwo();
  }

  void dequeue_ShouldDecrementSizeByOne(){
    queue.enqueue(x);
    queue.enqueue(x);

    queue.dequeue();
    expectQueueSizeIsOne();

    queue.dequeue();
    expectQueueIsEmpty();
  }

  void enqueue_WhenPastCapacity_ShouldThrowFullQueue(){
    void act(){
      queue.enqueue(x);
      queue.enqueue(x);
      queue.enqueue(x);
      queue.enqueue(x);
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
    queue.enqueue(x);
    expect(queue.dequeue(), equals(x));
  }

  void enqueue_dequeue_WhenXAndYAreEnqueued_XAndYShouldBeDequeued(){
    queue.enqueue(x);
    queue.enqueue(y);
    expect(queue.dequeue(), equals(x));
    expect(queue.dequeue(), equals(y));
  }

  void enqueue_ShouldEnqueueItemsInCorrectOrder(){
    _givenEnqueueXYZFollowdByOneDequeue();
    queue.enqueue(w);
    expect(queue.dequeue(), equals(y));
    expect(queue.dequeue(), equals(z));
   
  }

  void dequeue_ShouldDequeueItemsInCorrectOrder(){
    _givenEnqueueXYZFollowdByOneDequeue();
    queue.enqueue(w);
    expect(queue.dequeue(), equals(y));
    expect(queue.dequeue(), equals(z));
    expect(queue.dequeue(), equals(w));
  }

  void peek_GivenEnqueuingX_ShouldReturnX(){
    queue.enqueue(x);
    expect(queue.peek(), equals(x));
  }

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
      Test(enqueue_ShouldEnqueueItemsInCorrectOrder),
      Test(dequeue_ShouldDequeueItemsInCorrectOrder),
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

