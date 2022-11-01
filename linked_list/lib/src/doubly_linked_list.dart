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
  int indexOf(E entry) {
    for(var i = 0, current = _first; current != null; i++, current = current.next)
      if(current == entry)
        return i;
    
    return -1;
  }

  @override
  void reverse() {
  }
}

class DoublyLinkedListEntry<E extends DoublyLinkedListEntry<E>> extends LinkedListEntry<E> {
  E? previous;
}
