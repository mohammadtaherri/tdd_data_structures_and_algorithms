// ignore_for_file: non_constant_identifier_names
library stack_test;

import 'package:test/test.dart';
import 'package:clean_test/annotated_test.dart';
import 'package:stack/stack.dart';

void main() {
  runTests(libraryName: 'stack_test');
}

mixin ComposedExpect{

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



@TestCase()
@Root()
class StackTest with ComposedExpect{
  @override
  late final Stack stack;
}

@TestCase()
class GivenNewlyCreatedStackWith3Capacity extends StackTest{

  @SetUp()
  void createStackWith3Capacity() {
    stack = Stack<int>(capacity: 3);
  }

  @Test()
  void shouldBeEmpty(){
    expectStackIsEmpty();
  }

  @Test()
  void push_ShouldIncrementSizeByOne(){
    stack.push(10);
    expectStackSizeIsOne();

    stack.push(10);
    expectStackSizeIsTwo();
  }

  @Test()
  void push_WhenPastCapacity_ShouldThrowStackOverFlow(){
    void act(){
      stack.push(10);
      stack.push(10);
      stack.push(10);
      stack.push(10);
    }

    expect(act, throwsA(isA<StackOverflowException>()));
  }

  @Test()
  void pop_ShouldThrowStackUnderFLow(){
    void act(){
      stack.pop();
    }

    expect(act, throwsA(isA<StackUnderflowException>()));
  }

  @Test()
  void pop_GivenPushingTwoItems_ShouldDecrementSizeByOne(){
    stack.push(10);
    stack.push(10);

    stack.pop();
    expectStackSizeIsOne();

    stack.pop();
    expectStackIsEmpty();
  }

  @Test()
  void peek_ShouldThrowStackEmpty(){
    void act(){
      stack.peek();
    }

    expect(act, throwsA(isA<StackEmptyException>()));
  }

  @Test()
  void push_pop_WhenXIsPushed_XShouldBePopped(){
    final x = 10;
    stack.push(x);
    expect(stack.pop(), equals(x));
  }

  @Test()
  void push_pop_WhenXAndYArePushed_YAndXShouldBePopped(){
    final x = 10;
    final y = 20;
    stack.push(x);
    stack.push(y);
    expect(stack.pop(), equals(y));
    expect(stack.pop(), equals(x));
  }

  @Test()
  void peek_GivenPushingXAndY_ShouldReturnY(){
    final x = 10;
    final y = 20;
    stack.push(x);
    stack.push(y);
    expect(stack.peek(), equals(y));
  }
}

@TestCase()
class NegativeCapacityStack extends StackTest{

  @Test()
  void whenStackWithNegativeCapacityIsCreated_IllegalCapacityShouldBeThrown(){
    void act(){
      Stack<int>(capacity: -1);
    }

    expect(act, throwsA(isA<IllegalCapacityException>()));
  }
}

@TestCase()
class GivenZeroCapacityStack extends StackTest{

  @SetUp()
  void createStackWithZeroCapacity() {
    stack = Stack<int>(capacity: 0);
  }

  @Test()
  void shouldBeEmpty(){
    expectStackIsEmpty();
  }

  @Test()
  void push_ShouldThrowStackOverFlow(){
    void act(){
      stack.push(10);
    }

    expect(act, throwsA(isA<StackOverflowException>()));
  }

  @Test()
  void pop_ShouldThrowStackUnderFLow(){
    void act(){
      stack.pop();
    }

    expect(act, throwsA(isA<StackUnderflowException>()));
  }

  @Test()
  void peek_ShouldThrowStackEmpty(){
    void act(){
      stack.peek();
    }

    expect(act, throwsA(isA<StackEmptyException>()));
  }
}

