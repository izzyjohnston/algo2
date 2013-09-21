class Graph2
  
  attr_accessor :edges, :number_of_nodes
  def initialize(filename, nodes)
    self.number_of_nodes = nodes
    file = File.new(filename, "r")
    self.edges = file.map { |x| x.gsub(/\n/, "").split(" ").map(&:to_i) }.
                      map { |start, stop, weight| { start: start, stop: stop, weight: weight}}
    self.edges = self.edges.sort_by { |x| x[:weight]}
  end
  
  def cluster
    leaders = []
    set = UnionFind.new number_of_nodes
    i = 0
    edges.each do |edge|
      i += 1
      if !set.connected?(edge[:start], edge[:stop])
        leaders = set.union(edge[:start], edge[:stop])
      end
      if leaders.uniq{|x| x}.count == 5 #4 clusters plus nil 0
        puts edge
        break
      end
      
    end
    edges[i...edges.count].each do |edge|
      if !set.connected?(edge[:start], edge[:stop])
        puts edge
        print leaders.uniq{|x| x}
        return edge[:weight] #get first edge that would not cause a cycle
      end
    end
  end

end