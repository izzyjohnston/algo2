class Graph5
  attr_accessor :number_of_nodes, :raw_vertices
  def initialize(filename, nodes)
    self.number_of_nodes = nodes
    self.raw_vertices = []
    self.raw_vertices[0] = nil #hack to have 1st vertex start at one
    
    i = 1
    IO.foreach(filename) do |vertex|
      vertex.slice!("\n")
      vertex = vertex.delete(" ")
      sum = vertex.chars.map(&:to_i).inject(:+)
      (self.raw_vertices[sum] ||= []) << {vertex: vertex.to_i(2), order: i} #hack to remember original order when selecting close points
      i +=1
    end
    puts 'preprocessing done'
  end
  
  def cluster
    beginning = Time.now
    leaders = []
    #despite order by sum rank, set is still total # of nodes
    puts raw_vertices.count
    set = UnionFind.new number_of_nodes
    #go through array of hashes
    (0...raw_vertices.count).each do |i|
      puts i
      vs = raw_vertices[i]
      puts vs.nil? ? nil : vs.count
      #check if there are any vertices with the sum
      if !vs.nil?
        #find possible matches, i.e. the points with sums within 2 of the sum of the given point set
        close_points = raw_vertices[i..i+2]
        #for each point in the point set, compare to possible matches
        vs.each do |v1|
          close_points.each do |u|
            if !u.nil?
              u.each do |v2|
                if !set.connected? v1[:order], v2[:order]
                  #check if far
                  if !far? v1[:vertex], v2[:vertex]
                    leaders = set.union(v1[:order], v2[:order])
                  end
                end
              end
            end
          end
        end
      end
        
      # if v1[:order] % 100 == 0
#         puts v1[:order]
#       end
#       close_points = raw_vertices[v1[:order]+1..number_of_nodes].select {|v| far?(v[:vertex], v1[:vertex]) == false }
#       #raw_vertices[v1[:order]+1..number_of_nodes].each do |v2|
#       close_points.each do |v2|
#         if !set.connected?(v1[:order], v2[:order])
#           #if(!far? v1[:vertex], v2[:vertex])
#             leaders = set.union(v1[:order], v2[:order])
#             #end
#         end
#       end
    end
    # print leaders
    puts "Time elapsed #{Time.now - beginning} seconds"
    leaders.uniq{|x| x}.count - 1 #chop off nil
  end
  
  def far?(v1, v2)
    (v1^v2).to_s(2).count("1") > 2
  end
end
