function num = bit2float(bitString)
    num = bin2dec(num2str(bitString));
    num = (num/1024) - 0.5;
end