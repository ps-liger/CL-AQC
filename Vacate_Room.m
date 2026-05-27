function [vacate_I,PL_len,PL_room,total_Room] = Vacate_Room(PE_I,num_Of,Overflow,transform_code_bits)

[row,col] = size(PE_I); 
num = ceil(log2(row)) + ceil(log2(col));

Side = zeros(); 
num_Side = 0; 

Side(num_Side+1:num_Side+3) = transform_code_bits;
num_Side = num_Side + 3;

len_num_Of = zeros(1,num); 
bin2_num_Of = dec2bin(num_Of)-'0'; 
len = length(bin2_num_Of);
len_num_Of(num-len+1:num) = bin2_num_Of;
Side(num_Side+1:num_Side+num) = len_num_Of; 
num_Side = num_Side + num;    

if num_Of>0
    for i=1:num_Of
        x = Overflow(1,i); 
        y = Overflow(2,i);
        pos = (x-1)*col + y; 
        len_pos = zeros(1,num); 
        bin2_pos = dec2bin(pos)-'0'; 
        len = length(bin2_pos);
        len_pos(num-len+1:num) = bin2_pos;
        Side(num_Side+1:num_Side+num) = len_pos; 
        num_Side = num_Side + num; 
    end
end

Image_Bits = zeros(); 
t = 0; 
Image_Bits(t+1:t+num_Side) = Side; 
t = t+num_Side;

PL_room = zeros(1,8); 
PL_len = zeros(1,8); 
num_pl = 0; 

for pl=8:-1:1 
    
    [Plane] = BitPlanes_Extract(PE_I,pl);
    
    [CBS,type] = BitPlanes_Compress(Plane);
    
    len_CBS = length(CBS); 
    len_comp_PL = len_CBS+num+1; 
    
    if type == 1 && len_comp_PL <= row*col    
        
        num_pl = num_pl+1;
        Image_Bits(t+1) = 1; 
        t = t+1;
        
        len_CBS_bits = zeros(1,num); 
        bin2_len_CBS = dec2bin(len_CBS)-'0'; 
        len = length(bin2_len_CBS);
        len_CBS_bits(num-len+1:num) = bin2_len_CBS;
        Image_Bits(t+1:t+num) = len_CBS_bits; 
        t = t + num;
        
        Image_Bits(t+1:t+len_CBS) = CBS; 
        t = t + len_CBS;
        
        PL_len(pl) = len_CBS;
        room = row*col - len_comp_PL; 
        PL_room(pl) = room; 
        
    else
        Image_Bits(t+1) = 0; 
        t = t+1;
        T_Plane = Plane'; 
        PL_bits = reshape(T_Plane,1,row*col); 
        Image_Bits(t+1:t+row*col) = PL_bits; 
        t = t + row*col;
    end
end

vacate_I = PE_I;
num_t = 0; 

for pl=8:-1:1
    re = t - num_t; 
    if re >= row*col    
        PL_bits = Image_Bits(num_t+1:num_t+row*col); 
        num_t = num_t + row*col;
    else
        PL_bits = zeros(1,row*col);
        PL_bits(1:re) = Image_Bits(num_t+1:num_t+re); 
        num_t = num_t+re;    
    end
    
    Plane = reshape(PL_bits,col,row); 
    T_Plane = Plane'; 
    [RI] = BitPlanes_Embed(vacate_I,T_Plane,pl); 
    vacate_I = RI;
end

total_Room = row*col*8 - t; 
