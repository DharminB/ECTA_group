function truth_value = domination(a,b)
    truth_value =  (a(1) > b(1) && a(2) >= b(2)) || (a(1) >= b(1) && a(2) > b(2))
end