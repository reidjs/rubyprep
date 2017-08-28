def ftoc(temp_f)
    ((temp_f-32).to_f * (5.0/9.0)).to_i
end
def ctof(temp_c)
  (temp_c.to_f * (9.0/5.0)) + 32
end
