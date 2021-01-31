pub fn linear_search<T: PartialEq>(array: &[T], n: &T) -> i32 {
  for (i, x) in array.iter().enumerate() {
    if x == n { return i as i32; }
  }
  -1;
}
