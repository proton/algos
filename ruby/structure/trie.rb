# TODO: unfinished

class TrieNode
  attr_accessor :start, :finish, :min_idx, :children

  def initialize(start: 0, finish: 0, min_idx: 0)
    @start    = start
    @finish   = finish
    # @min_idx  = min_idx
    @children = {}
  end
end

class Trie
  attr_reader :root, :text

  REGEX = /[a-zA-Z0-9]+/

  def initialize(text)
    @text = text
    @root = TrieNode.new

    text.scan(REGEX).each { |word| add(word.downcase) }
  end

  def find(substring)
    positions = []

    node = root
    substring.each_char.with_index do |char, index|
      node = node.children[char]
      break if node.nil?

      positions << node.start if node.finish == index
    end

    positions
  end

  private def add(word)
    node = root
    word.each_char.with_index do |char, index|
      node.children[char] ||= TrieNode.new(start: index)
      node = node.children[char]
    end
    node.finish = word.size - 1
  end
end

text = <<~TEXT
  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
TEXT

trie = Trie.new(text)

p trie.find("dolor")

fail unless trie.find("dolor") == [12, 114, 222]
fail unless trie.find("ipsum") == [6, 158]
fail unless trie.find("lorem") == [0]
fail unless trie.find("nonexistent") == []
