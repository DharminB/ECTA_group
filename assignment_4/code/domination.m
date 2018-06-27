function truth_value = domination(a,b)
%     size(a,2)
    if size(a,2) == 2
        truth_value =  (a(1) > b(1) && a(2) >= b(2))|| (a(1) >= b(1) && a(2) > b(2));
    else
        truth_value =  (a(1) > b(1) && a(2) >= b(2) && a(3) >= b(3)) || (a(1) >= b(1) && a(2) > b(2) && a(3) >= b(3)) || (a(1) >= b(1) && a(2) >= b(2) && a(3) > b(3));
    end
end