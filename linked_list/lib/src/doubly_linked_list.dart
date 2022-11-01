part of linked_list;


class DoublyLinkedList<E extends DoublyLinkedListEntry<E>> extends _LinkedListBase<E>{

  @override
  @protected
  E? nodeBefore(E node) {
    return node.previous;
  }

  @override
  @protected
  void updateLinks({E? previousEntry, E? nextEntry}){
    super.updateLinks(previousEntry: previousEntry, nextEntry: nextEntry);
    nextEntry?.previous = previousEntry;
  }

  @override
  @protected
  void unlinke(E? entry){
    super.unlinke(entry);
    entry?.previous = null;
  }

  @override
  void reverse() {
    if(size <= 1)
      return;

    var previous = first;
    var current = first!.next;

    while(current != null){
      var currentTemp = current.next;
      var previousTemp = previous!.next;
      current.next = previous;
      previous.previous = current;
      current = currentTemp;
      previous = previousTemp;
    }

    var temp = first;
    _first = _last;
    _last = temp;

    first!.previous = null;
    last!.next = null;
  }
}

class DoublyLinkedListEntry<E extends DoublyLinkedListEntry<E>> extends LinkedListEntry<E> {
  E? previous;
}
