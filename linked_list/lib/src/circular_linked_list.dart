part of linked_list;

class CircularLinkedList<E extends LinkedListEntry<E>> extends _LinkedListBase<E>{

  @override
  @protected
  void updateLinks({E? previousEntry, E? nextEntry}){
    super.updateLinks(previousEntry: previousEntry, nextEntry: nextEntry);
    last?.next = first;
  }

  @override
  indexOf(E entry) {
    for (var c = _first, i = 0; c != null; c = c.next, i++)
      if (c == entry) 
        return i;

    return -1;
  }

  @override
  void reverse() {
    if(size <= 1)
      return;
  }
}