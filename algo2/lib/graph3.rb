class Graph3
  attr_accessor :number_of_nodes, :raw_vertices
  def initialize(filename, nodes)
    self.number_of_nodes = nodes
    self.raw_vertices = []
    self.raw_vertices[0] = nil #hack to have 1st vertex start at one
    
    i = 1
    IO.foreach(filename) do |vertex|
      vertex.slice!("\n")
      self.raw_vertices << {vertex: vertex, sum: vertex.split('').map(&:to_i).inject{|sum, x| sum + x}, order: i} #hack to remember original order when selecting close points
      i +=1
    end
    puts 'preprocessing done'
  end
  
  def cluster
    beginning = Time.now
    leaders = []
    set = UnionFind.new number_of_nodes
    #start at node 1 up to last node
    # (1..number_of_nodes).each do |i|
    #   v1 = raw_vertices[i]
    
      
      #look at all subsequent nodes, no need to look back
      # ((i+1)..number_of_nodes).each do |j|
#         if !set.connected?(i, j)
#           v2 = raw_vertices[j]
#           if (!v2.nil? && (v1[:sum] - v2[:sum]).abs < 3) 
#             if (!far?(v1[:vertex], v2[:vertex]))
#               leaders = set.union(i, j)
#             end
#           end
#         end
#       end
    raw_vertices[1..number_of_nodes].each do |v1|
      #only look at nodes with close sums
      #doesn't seem to help much though
      puts v1[:order]
      close_points = raw_vertices[v1[:order]+1..number_of_nodes].select {|v| (v[:sum] - v1[:sum]).abs < 3 }
      close_points.each do |v2|
        if !set.connected?(v1[:order], v2[:order])
          if(!far? v1[:vertex], v2[:vertex])
            leaders = set.union(v1[:order], v2[:order])
          end
        end
      end
    end
    # print leaders
    puts "Time elapsed #{Time.now - beginning} seconds"
    leaders.uniq{|x| x}.count - 1 #chop off nil
  end
  
  def far?(v1, v2)
    puts (v1^v2).to_s(2).count("1")
    # diff = 0
#     far = false
#     (0..v1.length).each do |i|
#       if v1[i] != v2[i]
#         diff +=1
#         if (diff > 2)
#           far = true #return when there are more than 2 differences
#           break
#         end
#       end
#     end
#     far
  end
end
