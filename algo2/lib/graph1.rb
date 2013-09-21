class Containers::MinHeap
  def [](key)
    @stored[key]
  end
end

class Graph1
  attr_accessor :vertices
  def initialize(filename)
    self.vertices = {}
    IO.foreach(filename) do |edge|
      start, stop, cost = edge.split(' ')
      #add both ways since non-directed
      (self.vertices[start] ||= []) << [stop, cost.to_i]
      (self.vertices[stop] ||= []) << [start, cost.to_i]
    end
  end
  
  def cost
    #pick random integer between 1 and vertex length to ensure that you get the same answer every time
    vertex = rand(1..vertices.length)
    puts "vertex"
    puts vertex
    prim_heap(vertex.to_s)
  end
  
  def prim_heap(u)
    path = 0
    edges = vertices[u]
    frontier  = Set.new(vertices.keys.reject { |v| v == u }) #all unexplored vertices
    min_heap = Containers::MinHeap.new
    
    #push all edges of u to heap
    edges.each do |v, cost|
      min_heap.push(cost, v)
    end
    
    while !frontier.empty?
      shortest_path = min_heap.next_key #get the shortest edge in the heap
      
      #remove v since that is the one we are going to
      v             = min_heap.pop 
      # completely possible that the next shortest path was to something we already processed
      if frontier.include? v
        frontier.delete(v) 
      
        path += shortest_path #update length of path to be the path we picked
      
        #get all the edges connected to v and add them to the heap
        if vertices[v].present?
          vertices[v].each do |w, cost|
            if frontier.include? w
              #only add the nodes that haven't been seen
              min_heap.push(cost, w)
            end
          end
        end
      end
      
      
    end
    path
  end
end
