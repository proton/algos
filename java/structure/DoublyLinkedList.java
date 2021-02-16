import java.util.Iterator;
import java.util.List;
import java.util.ArrayList;

class DoublyLinkedList<T> {
  class Node<T> {
    T value;
    Node<T> nextNode;
    Node<T> prevNode;

    Node(T value) {
      this.value = value;
    }
  }

  private class LinkedListIterator<T> implements Iterator<T> {
    private Node<T> current;

    public LinkedListIterator(Node<T> head) {
      current = head;
    }

    @Override
    public void remove() {
      throw new UnsupportedOperationException();
    }

    @Override
    public boolean hasNext() {
      return current != null;
    }

    @Override
    public T next() {
      if (!hasNext()) return null;

      var item = current.value;
      current = current.nextNode;

      return item;
    }
  }

  private Node<T> head;
  private Node<T> tail;
  int length = 0;

  DoublyLinkedList() {
   //
  }

  DoublyLinkedList(T[] array) {
    for (int i = 0; i < array.length; ++i) {
      push(array[i]);
    }
  }

  public T first() {
    if (length == 0) return null;
    return head.value;
  }

  public T last() {
    if (length == 0) return null;
    return tail.value;
  }

  public T at(int index) {
    if (length == 0) return null;

    var node = _nodeAt(index);
    if (node == null) return null;
    return node.value;
  }

  public T push(T value) {
    var node = new Node<T>(value);
    if (head == null) {
      head = node;
      tail = node;
    } else {
      tail.nextNode = node;
      node.prevNode = tail;
      tail = node;
    }
    length += 1;
    return value;
  }

  public T prepend(T value) {
    var prevHead = head;
    head = new Node<T>(value);
    head.nextNode = prevHead;
    prevHead.prevNode = head;
    length += 1;
    return value;
  }

  public T pop() {
    if (tail == null) return null;

    var lastValue = tail.value;
    var node = tail.prevNode;
    if (node != null) node.nextNode = null;
    tail = node;

    length -= 1;
    return lastValue;
  }

  public T popFront() {
    if (head == null) return null;

    var oldHead = this.head;
    head = oldHead.nextNode;
    head.prevNode = null;
    length -= 1;
    return oldHead.value;
  }

  public T insert(int position, T value) {
    var prevNode = _nodeAt(position - 1);
    var nextNode = prevNode.nextNode;
    var node = new Node<T>(value);
    node.prevNode = prevNode;
    node.nextNode = nextNode;
    prevNode.nextNode = node;
    length += 1;
    return value;
  }

  public T remove(int position) {
    if (position == 0) return popFront();

    var prevNode = _nodeAt(position - 1);
    var node = prevNode.nextNode;
    var nextNode = node.nextNode;
    prevNode.nextNode = nextNode;
    if (nextNode != null) {
      nextNode.prevNode = prevNode;
    } else {
      tail = prevNode;
    }
    length -= 1;
    return nextNode.value;
  }

  public Iterator<T> iterator() {
    return new LinkedListIterator<T>(head);
  }

  public Boolean contains(T searchValue) {
    var node = this.head;
    while(node != null) {
      if (node.value == searchValue) return true;
      node = node.nextNode;
    }
    return false;
  }

  public ArrayList<T> toArray() {
    var array = new ArrayList<T>();
    var it = iterator();
    for (int i = 0; i < length; ++i) {
      array.add(it.next());
    }
    return array;
  }

  private Node<T> _nodeAt(int index) {
    if (index >= length) return null;

    Node<T> node = null;
    if (index < length / 2) {
      int counter = 0;
      node = head;
      while(node != null && counter < index) {
        node = node.nextNode;
        counter += 1;
      }
    } else {
      int counter = length - 1;
      node = tail;
      while(node != null && counter > index) {
        node = node.prevNode;
        counter -= 1;
      }
    }
    return node;
  }

  public static void main(String[] args) {
    // var list = new DoublyLinkedList<Integer>();
    // assert list.toArray().equals(List.of());
    // assert list.length == 0;

    // Integer[] init = {};
    // list = new DoublyLinkedList<Integer>(init);
    // assert list.toArray().equals(List.of());
    // assert list.length == 0;

    // Integer[] init2 = {1, 2, 3};
    // list = new DoublyLinkedList<Integer>(init2);
    // assert list.toArray().equals(List.of(1, 2, 3));
    // assert list.length == 3;
    // assert !list.contains(0);
    // assert list.contains(1);
    // assert list.contains(2);
    // assert list.contains(3);
    // assert !list.contains(4);

    // list.push(4);
    // assert list.length == 4;
    // list.prepend(0);
    // assert list.toArray().equals(List.of(0, 1, 2, 3, 4));
    // assert list.length == 5;

    // assert list.pop() == 4;
    // assert list.length == 4;
    // assert list.popFront() == 0;
    // assert list.length == 3;

    // list.insert(1, 9);
    // assert list.toArray().equals(List.of(1, 9, 2, 3));
    // assert list.length == 4;

    // list.remove(0);
    // assert list.toArray().equals(List.of(9, 2, 3));
    // assert list.length == 3;

    // list.remove(1);
    // assert list.toArray().equals(List.of(9, 3));
    // assert list.length == 2;

    // assert list.at(0) == 9;
    // assert list.at(1) == 3;
    // assert list.at(2) == null;
  }
}
