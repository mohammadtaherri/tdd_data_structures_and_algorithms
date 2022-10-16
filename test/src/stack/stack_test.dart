// ignore_for_file: non_constant_identifier_names
library stack_test;

import 'package:test/test.dart';
import 'package:clean_test/clean_test.dart';
import 'package:tdd_data_structures_and_algorithms/src/stack/stack.dart';

part 'tests/empty_stack_with_3_capacity.dart';
part 'tests/zero_capasity_stack.dart';

void main() {
  runTest(StackTest());
}

class StackTest extends RootTestGroup {
  StackTest(): super(
    groups: [
      GivenZeroCapacityStack(),
      GivenEmptyStackWith3Capacity(),
    ]
  );

  void whenStackWithNegativeCapcityIsCreated_SHouldThrowIllegalCapacity(){
    void act(){
      Stack(capacity: -1);
    }
    expect(act, throwsA(isA<IllegalCapacity>()));
  }

  @override
  void registerTests(TestContainer container) {
    container['when stack with negative capacity is created, should throw IllegalCapacity'] = 
      Test(whenStackWithNegativeCapcityIsCreated_SHouldThrowIllegalCapacity);
  }
}








