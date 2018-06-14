function num = bit2float(bitString, nBit)
    [nRows, nCols] = size(bitString);
    nFloat = nCols/nBit;
    num = zeros(nRows, nFloat);
    for r = 1:nRows
        for c = 1:nFloat
            bs = bitString(r,((c-1)*nBit+1):((c-1)*nBit+1)+nBit-1);
            number = bin2dec(num2str(bs));
            number = (number/(2^nBit)) - 0.5;                           
            num(r,c) = number;
        end
    end
    
    
end