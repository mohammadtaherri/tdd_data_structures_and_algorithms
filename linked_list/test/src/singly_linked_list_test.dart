import 'package:test/test.dart';
import 'package:clean_test/clean_test.dart';
import 'package:linked_list/linked_list.dart';

void main() {
  runTest(SinglyLinkedListTest());
}

class SinglyLinkedListTest extends RootTestGroup {
  SinglyLinkedListTest()
      : super(groups: [
          GivenNewlyCreatedList(
            groups: [],
          )
        ]);
}

class GivenNewlyCreatedList extends BranchTestGroup{
  GivenNewlyCreatedList({required super.groups})
      : super(groupDescription: 'given newly created list');

  late SinglyLinkedList linkedList;

  @override
  void setUp() {
    linkedList = SinglyLinkedList();
  }

  void shouldBeEmpty(){
    expect(linkedList.isEmpty, isTrue);
    expect(linkedList.size, isZero);
  }

  void firstAndLastShouldBeNull(){
    expect(linkedList.first, isNull);
    expect(linkedList.last, isNull);
  }

  @override
  void registerTests(TestContainer container) {
    container['should be empty'] = 
        Test(shouldBeEmpty);

    container['first and last should be null'] = 
        Test(firstAndLastShouldBeNull);
  }
}