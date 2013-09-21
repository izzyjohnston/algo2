class Assignment1
  
  def self.diff_solve
    jobs = Job.new("#{Rails.root}/tmp/jobs.txt", 'diff')
    jobs.completion_sum
  end
  def self.diff_test
    jobs = Job.new("#{Rails.root}/tmp/jobs_test_case1.txt", 'diff')
    jobs.completion_sum
  end
  
  def self.ratio_solve
    jobs = Job.new("#{Rails.root}/tmp/jobs.txt", 'ratio')
    jobs.completion_sum
  end
  def self.ratio_test
    jobs = Job.new("#{Rails.root}/tmp/jobs_test_case1.txt", 'ratio')
    jobs.completion_sum
  end
  
  def self.prims_solve
    graph = Graph1.new("#{Rails.root}/tmp/edges.txt")
    graph.cost
  end
  def self.prims_test
    graph = Graph1.new("#{Rails.root}/tmp/edges_test_case2.txt")
    graph.cost
  end
  
end
