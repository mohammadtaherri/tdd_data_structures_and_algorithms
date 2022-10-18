part of linked_list;

class SinglyLinkedList<E extends LinkedListEntry>{

  bool get isEmpty => _size == 0;
  int get size => _size;
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

  void removeLast() {
    throw IllegalState();
  }
}

class LinkedListEntry{}