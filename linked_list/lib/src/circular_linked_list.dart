part of linked_list;

class CircularLinkedList<E extends LinkedListEntry<E>> extends _LinkedListBase<E>{

  @override
  @protected
  void updateLinks({E? previousEntry, E? nextEntry}){
    super.updateLinks(previousEntry: previousEntry, nextEntry: nextEntry);
    last?.next = first;
  }

  @override
  void reverse() {
    if(size <= 1)
      return;

    var previous = first;
    var current = first!.next;

    while(current != first){
      var temp = current!.next;
      current.next = previous;
      previous = current;
      current = temp;
    }

    var temp = first;
    _first = _last;
    _last = temp;

    last!.next = first;
  }
}