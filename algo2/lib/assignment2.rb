class Assignment2
  def self.clustering_solve
    graph = Graph2.new("#{Rails.root}/tmp/clustering1.txt", 500)
    graph.cluster
  end
  def self.clustering_test
    #graph = Graph2.new("#{Rails.root}/tmp/kruskal_test_case1.txt", 9)
    graph = Graph2.new("#{Rails.root}/tmp/kruskal_test_case2.txt", 200)
    graph.cluster
    
  end 
  
  def self.clustering_big_solve
    #graph = Graph4.new("#{Rails.root}/tmp/clustering_big.txt", 200000)
    graph = Graph5.new("#{Rails.root}/tmp/clustering_big.txt", 200000)
    graph.cluster
  end
  
  def self.clustering_big_test
    #graph = Graph4.new("#{Rails.root}/tmp/clustering_big_test_case1.txt", 10)
    graph = Graph5.new("#{Rails.root}/tmp/clustering_big_test_case2.txt", 2000)
    graph.cluster
  end 
end
