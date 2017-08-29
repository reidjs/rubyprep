def measure (val=1, &b)
  ntimes = []
  val.times do
    x = Time.now
    b.call
    ntimes << Time.now - x
  end
  ntimes.inject{|sum, e| sum+=e} / val 
end
