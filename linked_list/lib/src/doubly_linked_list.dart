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
  }
}

class DoublyLinkedListEntry<E extends DoublyLinkedListEntry<E>> extends LinkedListEntry<E> {
  E? previous;
}
