public class BubbleSort {
  public static <T extends Comparable<T>> void bubble_sort(T[] array) {    
    for (int i = 0; i < array.length; ++i) {
      for (int j = 0; j < array.length - 1 - i; ++j) {
        if (array[j].compareTo(array[j + 1]) > 0) {
          T buf = array[j];
          array[j] = array[j + 1];
          array[j + 1] = buf;
        }
      }
    }
  }
}