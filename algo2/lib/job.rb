class Job
  attr_accessor :jobs
  def initialize(filename, type)
    self.jobs = []
    IO.foreach(filename) do |job|
      weight,length = job.split(' ')
      score = (type == 'diff') ? weight.to_i - length.to_i : (weight.to_f/length.to_f)
      self.jobs << {weight: weight.to_i, length: length.to_i, score: score}
    end
    self.jobs = self.jobs.sort { |a, b| [b[:score], b[:weight]] <=> [a[:score], a[:weight]] }
    puts self.jobs
  end

  def completion_sum
    run_time = 0
    completion_time = 0
    jobs.each do |job|
      run_time += job[:length]
      completion_time += run_time * job[:weight]
    end
    completion_time
  end
  
end