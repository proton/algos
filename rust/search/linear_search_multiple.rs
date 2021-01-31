pub fn linear_search_multiple<T: PartialEq>(array: &[T], n: &T) -> Vec<i32> {
  let mut indexes : Vec<i32> = Vec::new();
  for (i, x) in array.iter().enumerate() {
    if x == n {
      indexes.push(i as i32);
    }
  }
  return indexes;
}