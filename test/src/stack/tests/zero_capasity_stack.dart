// ignore_for_file: non_constant_identifier_names
part of stack_test;

class GivenZeroCapacityStack extends LeafTestGroup{
  GivenZeroCapacityStack(): super(groupDescription: 'given zero capasity stack');

  late Stack stack;

  @override
  void setUp() {
    stack = Stack(capacity: 0);
  }

  void shouldBeEmpty(){
    expect(stack.isEmpty, isTrue);
    expect(stack.size, isZero);
  }

  void anyPush_ShouldThrowStackOverFlow(){
    void act(){
      stack.push(10);
    }

    expect(act, throwsA(isA<StackOverFlow>()));
  }

  void anyPop_ShouldThrowStackUnderFlow(){
    void act(){
      stack.pop();
    }

    expect(act, throwsA(isA<StackUnderFlow>()));
  }

  void anyTop_ShouldThrowStackEmpty(){
    void act(){
      stack.top();
    }

    expect(act, throwsA(isA<StackEmpty>()));
  }


  @override
  void registerTests(TestContainer container) {
    container['should be empty'] = 
        Test(shouldBeEmpty);

    container['any push should throw StackOverFlow'] = 
      Test(anyPush_ShouldThrowStackOverFlow);

    container['any pop should throw StackUnderFlow'] = 
      Test(anyPop_ShouldThrowStackUnderFlow);

    container['any top should throw StackEmpty'] = 
      Test(anyTop_ShouldThrowStackEmpty);
  }
}