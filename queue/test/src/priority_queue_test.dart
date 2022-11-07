// ignore_for_file: non_constant_identifier_names
import 'package:dartunit/dartunit.dart';

import 'package:queue/queue.dart';
import '../queue_test.dart';
import 'matchers.dart';


class AscendingQueueItem extends PriorityQueueItem<AscendingQueueItem>{
  AscendingQueueItem(this.value);
  final int value;

  @override
  int comparePriorityWith(AscendingQueueItem other){
    if(value > other.value)
      return 1;

    if(value < other.value)
      return -1;

    return 0;
  }
}


@TestCase()
@Root()
class PriorityQueueTest extends QueueTest{
  @override
  late final PriorityQueue<AscendingQueueItem> queue;
}

@TestCase()
class  GivenNewlyCreatedPriorityQueueWith3Capacity extends PriorityQueueTest {

  late final AscendingQueueItem x, y, z;
  
  @SetUp()
  void createNewPriorityQueueWith3Capacity(){
    queue = PriorityQueue(capacity: 3);

    x = AscendingQueueItem(10);
    y = AscendingQueueItem(20);
    z = AscendingQueueItem(30);
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
  void enqueue_ShouldIncrementSizeByOne(){
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
  void enqueue_dequeue_WhenXAndYAreEnqueued_YAndXShouldBeDequeued(){
    queue.enqueue(x);
    queue.enqueue(y);
    expect(queue.dequeue(), equals(y));
    expect(queue.dequeue(), equals(x));
  }

  @Test()
  void enqueue_WhenYAndXAreEnqueued_YAndXShouldBeDequeued(){
    queue.enqueue(y);
    queue.enqueue(x);
    expect(queue.dequeue(), equals(y));
    expect(queue.dequeue(), equals(x));
  }

  @Test()
  void enqueue_WhenZAndYAndXAreEnqueued_ZAndyAndXShouldBeDequeued(){
    queue.enqueue(z);
    queue.enqueue(y);
    queue.enqueue(x);
    expect(queue.dequeue(), equals(z));
    expect(queue.dequeue(), equals(y));
    expect(queue.dequeue(), equals(x));
  }

  @Test()
  void peek_GivenEnqueuingX_ShouldReturnX(){
    queue.enqueue(x);
    expect(queue.peek(), equals(x));
  }
}

@TestCase()
class  NegativeCapacityPriorityQueue extends PriorityQueueTest {
  @Test()
  void whenQueueWithNegativeCapacityIsCreated_ThenIllegalCapcityShouldBeThrown(){
    void act(){
      PriorityQueue<AscendingQueueItem>(capacity: -1);
    }

    expect(act, throwsAIllegalCapcity);
  }
}

@TestCase()
class GivenZeroCapacityPriorityQueue extends PriorityQueueTest{

  @SetUp()
  void createNewStackQueueWithZeroCapacity() {
    queue = PriorityQueue<AscendingQueueItem>(capacity: 0);
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
      queue.enqueue(AscendingQueueItem(10));
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

