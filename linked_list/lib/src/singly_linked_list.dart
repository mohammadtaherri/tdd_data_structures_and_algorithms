part of linked_list;

class SinglyLinkedList<E extends LinkedListEntry>{
  get isEmpty => _size == 0;

  get size => _size;
  int _size = 0;

  get first => null;

  get last => null;

  void addFirst(E entry) {
    _size++;
  }

  void addLast(E entry) {
    _size++;
  }

  void removeFirst() {
    throw IllegalState();
  }
}

class LinkedListEntry{}