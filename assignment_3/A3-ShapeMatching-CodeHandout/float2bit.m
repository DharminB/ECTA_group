function bitString = float2bit(num)
    num = (num + 0.5)*1024;
    num = floor(num);
    bitString = dec2bin(num) - '0';
end