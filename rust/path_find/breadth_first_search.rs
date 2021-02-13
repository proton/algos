use std::collections::HashMap;
use std::collections::HashSet;
use std::collections::VecDeque;

struct BreadthFirstSearch {
    graph: HashMap<usize, HashSet<usize>>,
    visited: HashSet<usize>,
}

impl BreadthFirstSearch {
    pub fn new() -> BreadthFirstSearch {
        return BreadthFirstSearch {
            graph: HashMap::new(),
            visited: HashSet::new(),
        };
    }

    pub fn connect(&mut self, a: usize, b: usize) {
        if !self.graph.contains_key(&a) {
            self.graph.insert(a, HashSet::new());
        }
        self.graph.entry(a).and_modify(|neighbours| { neighbours.insert(b); } );
    }

    pub fn distance(&mut self, from: usize, to: usize) -> usize {
        self.visited = HashSet::new();
        let mut search_queue = VecDeque::new();
        for neigbour in self.graph.get(&from).unwrap() {
            search_queue.push_back((1, neigbour));
        }

        while !search_queue.is_empty() {
            let entry = search_queue.pop_front().unwrap();
            let distance = entry.0;
            let node = *entry.1;
            if node == to {
                return distance;
            }
            let neighbours = self.graph.get(&node);
            if let Some(neighbours) = neighbours {
                for neighbour in neighbours {
                    if !self.visited.contains(neighbour) {
                        self.visited.insert(*neighbour);
                        search_queue.push_back((distance + 1, neighbour));
                    }
                }
            }
        }
        return usize::MAX;
    }
}

pub fn main() {
  let mut bfs = BreadthFirstSearch::new();
  bfs.connect(1, 2);
  bfs.connect(2, 3);
  bfs.connect(2, 4);
  bfs.connect(3, 5);
  println!("{}", bfs.distance(1, 5));
}
