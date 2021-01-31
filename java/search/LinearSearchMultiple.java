import java.util.ArrayList;

public class LinearSearchMultiple {
  public static <T extends Comparable<T>> int[] linearSearchMultiple(T[] array, T n) {
    var indexes = new ArrayList<Integer>();  
    for(int i = 0 ; i < array.length; ++i) {    
      if (array[i].equals(n)) {
        indexes.add(i);
      } 
    }
    return indexes.stream().mapToInt(i -> i).toArray();
  } 
}