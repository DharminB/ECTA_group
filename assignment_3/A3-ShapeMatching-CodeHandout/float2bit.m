function bitString = float2bit(num, nBit)
    num = (num + 0.5)*(2^nBit);
    num = floor(num);
    bitString = dec2bin(num, nBit) - '0';
end