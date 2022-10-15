// ignore_for_file: non_constant_identifier_names
part of stack_test;

class GivenEmptyStackWith3Capacity extends LeafTestGroup{
  GivenEmptyStackWith3Capacity()
      : super(groupDescription: 'given empty stack with 3 capacity');

  late Stack stack;

  @override
  void setUp() {
    stack = Stack(capacity: 3);
  }

  void shouldBeEmpty(){
    expect(stack.isEmpty, isTrue);
    expect(stack.size, isZero);
  }

  void afterOnePush_SizeShouldBeOne(){
    stack.push(10);
    expect(stack.size, equals(1));
    expect(stack.isEmpty, isFalse);
  }
  
  void afterTwoPushes_SizeShouldBeTwo(){
    stack.push(10);
    stack.push(10);
    expect(stack.size, equals(2));
    expect(stack.isEmpty, isFalse);
  }

  void afterOnePushAndOnePop_SizeShouldBeZero(){
    stack.push(10);
    stack.pop();
    expect(stack.size, isZero);
    expect(stack.isEmpty, isTrue);
  }

  void whenPushesPastCapacity_ShouldThrowStackOverFlow(){
    void act(){
      stack.push(10);
      stack.push(10);
      stack.push(10);
      stack.push(10);
    }

    expect(act, throwsA(isA<StackOverFlow>()));
  }

  void whenPopIsCalled_ShouldThrowStackUnderFlow(){
    void act(){
      stack.pop();
    }

    expect(act, throwsA(isA<StackUnderFlow>()));
  }

  void whenTopIsCalled_ShouldThrowStackEmpty(){
    void act(){
      stack.top();
    }

    expect(act, throwsA(isA<StackEmpty>()));
  }

  void whenXIsPushed_XShouldBePopped(){
    int x = 10;
    stack.push(x);
    expect(stack.pop(), equals(x));
  }

  void whenXAndYArePushed_YAndXShouldBePopped(){
    int x = 10;
    int y = 20;
    stack.push(x);
    stack.push(y);
    expect(stack.pop(), equals(y));
    expect(stack.pop(), equals(x));
  }

  void whenXIsPushed_XShouldBeOnTop(){
    int x = 10;
    stack.push(x);
    expect(stack.top(), equals(x));
  }

 
  @override
  void registerTests(TestContainer container) {
    container['should be empty'] = 
        Test(shouldBeEmpty);

    container['after one push, size should be one'] =
        Test(afterOnePush_SizeShouldBeOne);

    container['after Two push, size should be Two'] =
        Test(afterTwoPushes_SizeShouldBeTwo);

    container['after one push and one pop, size should be zero'] =
        Test(afterOnePushAndOnePop_SizeShouldBeZero);

    container['when pushes past capacity, should throw StackOverFlow'] =
        Test(whenPushesPastCapacity_ShouldThrowStackOverFlow);

    container['when pop is called, should throw StackUnderFlow'] =
        Test(whenPopIsCalled_ShouldThrowStackUnderFlow);

    container['when top is called, should throw StackEmpty'] =
        Test(whenTopIsCalled_ShouldThrowStackEmpty);

    container['when x is pushed, x should be popped'] =
        Test(whenXIsPushed_XShouldBePopped);

    container['when x and y are pushed, y and x should be popped'] =
        Test(whenXAndYArePushed_YAndXShouldBePopped);

    container['when x is pushed, x should be on top'] =
        Test(whenXIsPushed_XShouldBeOnTop);
  }
}