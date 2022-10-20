// ignore_for_file: non_constant_identifier_names
import 'package:test/test.dart';
import 'package:clean_test/clean_test.dart';
import 'package:stack/stack.dart';

void main() {
  runTest(StackTest());
}

class StackTest extends RootTestGroup{
  StackTest()
    : super(
      groups: [
        GivenNwelyCreatedStackWithPositiveCapacity(),
        NegativeCapacityStack(),
        GivenZeroCapacityStack(),
      ],
    );
}

class GivenNwelyCreatedStackWithPositiveCapacity extends LeafTestGroup with ComposedExpect{

  @override
  late Stack<int> stack;

  @override
  void setUp() {
    stack = Stack<int>(capacity: 3);
  }

  void shouldBeEmpty(){
    expectStackIsEmpty();
  }

  void push_ShouldIncrementSizeByOne(){
    stack.push(10);
    expectStackSizeIsOne();

    stack.push(10);
    expectStackSizeIsTwo();
  }

  void push_WhenPastCapacity_ShouldThrowStackOverFlow(){
    void act(){
      stack.push(10);
      stack.push(10);
      stack.push(10);
      stack.push(10);
    }

    expect(act, throwsA(isA<StackOverflowException>()));
  }

  void pop_ShouldThrowStackUnderFLow(){
    void act(){
      stack.pop();
    }

    expect(act, throwsA(isA<StackUnderflowException>()));
  }

  void pop_GivenPushingTwoItems_ShouldDecrementSizeByOne(){
    stack.push(10);
    stack.push(10);

    stack.pop();
    expectStackSizeIsOne();

    stack.pop();
    expectStackIsEmpty();
  }

  void peek_ShouldThrowStackEmpty(){
    void act(){
      stack.peek();
    }

    expect(act, throwsA(isA<StackEmptyException>()));
  }

  void push_pop_WhenXIsPushed_XShouldBePopped(){
    final x = 10;
    stack.push(x);
    expect(stack.pop(), equals(x));
  }

  void push_pop_WhenXAndYArePushed_YAndXShouldBePopped(){
    final x = 10;
    final y = 20;
    stack.push(x);
    stack.push(y);
    expect(stack.pop(), equals(y));
    expect(stack.pop(), equals(x));
  }

  void peek_GivenPushingXAndY_ShouldReturnY(){
    final x = 10;
    final y = 20;
    stack.push(x);
    stack.push(y);
    expect(stack.peek(), equals(y));
  }

  @override
  void registerTests(TestContainer container) {
    container.addAll([
      Test(shouldBeEmpty),
      Test(push_ShouldIncrementSizeByOne),
      Test(push_WhenPastCapacity_ShouldThrowStackOverFlow),
      Test(pop_ShouldThrowStackUnderFLow),
      Test(pop_GivenPushingTwoItems_ShouldDecrementSizeByOne),
      Test(peek_ShouldThrowStackEmpty),
      Test(push_pop_WhenXIsPushed_XShouldBePopped),
      Test(push_pop_WhenXAndYArePushed_YAndXShouldBePopped),
      Test(peek_GivenPushingXAndY_ShouldReturnY),
    ]);
  }
}

class NegativeCapacityStack extends LeafTestGroup{

  void whenStackWithNegativeCapacityIsCreated_IllegalCapacityShouldBeThrown(){
    void act(){
      Stack<int>(capacity: -1);
    }

    expect(act, throwsA(isA<IllegalCapacityException>()));
  }

  @override
  void registerTests(TestContainer container) {
    container.addAll([
      Test(whenStackWithNegativeCapacityIsCreated_IllegalCapacityShouldBeThrown),
    ]);
  }
}


class GivenZeroCapacityStack extends LeafTestGroup with ComposedExpect{

  @override
  late Stack<int> stack;

  @override
  void setUp() {
    stack = Stack<int>(capacity: 0);
  }

  void shouldBeEmpty(){
    expectStackIsEmpty();
  }

  void push_ShouldThrowStackOverFlow(){
    void act(){
      stack.push(10);
    }

    expect(act, throwsA(isA<StackOverflowException>()));
  }

  void pop_ShouldThrowStackUnderFLow(){
    void act(){
      stack.pop();
    }

    expect(act, throwsA(isA<StackUnderflowException>()));
  }

  void peek_ShouldThrowStackEmpty(){
    void act(){
      stack.peek();
    }

    expect(act, throwsA(isA<StackEmptyException>()));
  }

  @override
  void registerTests(TestContainer container) {
    container.addAll([
      Test(shouldBeEmpty),
      Test(push_ShouldThrowStackOverFlow),
      Test(pop_ShouldThrowStackUnderFLow),
      Test(peek_ShouldThrowStackEmpty),
    ]);
  }
}

mixin ComposedExpect on TestGroup{

  Stack get stack;

  void expectStackIsEmpty(){
    expect(stack.isEmpty, isTrue);
    expect(stack.size, isZero);
  }

  void expectStackSizeIsOne(){
    expect(stack.size, equals(1));
    expect(stack.isEmpty, isFalse);
  }

  void expectStackSizeIsTwo(){
    expect(stack.size, equals(2));
    expect(stack.isEmpty, isFalse);
  }
}