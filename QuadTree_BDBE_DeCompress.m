function bit_plane = QuadTree_BDBE_DeCompress(compressed_stream, total_row, total_col, start_idx)

bit_plane = zeros(total_row, total_col);
stream = compressed_stream;
idx = start_idx;

stack = struct('sr', {}, 'sc', {}, 'er', {}, 'ec', {}, 'stage', {});

stack(1).sr = 1;
stack(1).sc = 1;
stack(1).er = total_row;
stack(1).ec = total_col;
stack(1).stage = 0;  

while ~isempty(stack)
    curr = stack(end);
    
    sr = curr.sr; sc = curr.sc; er = curr.er; ec = curr.ec;
    
    rows = er - sr + 1;
    cols = ec - sc + 1;
    bsize = min(rows, cols);
    
    if curr.stage == 0
        
        if bsize > 16
            
            half_r = ceil(rows / 2);
            half_c = ceil(cols / 2);
            
            stack(end) = [];
            
            for sub = 4:-1:1
                switch sub
                    case 4  
                        new_stack.sr = sr + half_r;
                        new_stack.sc = sc + half_c;
                        new_stack.er = er;
                        new_stack.ec = ec;
                    case 3  
                        new_stack.sr = sr + half_r;
                        new_stack.sc = sc;
                        new_stack.er = er;
                        new_stack.ec = min(sc+half_c-1, ec);
                    case 2  
                        new_stack.sr = sr;
                        new_stack.sc = sc + half_c;
                        new_stack.er = min(sr+half_r-1, er);
                        new_stack.ec = ec;
                    case 1  
                        new_stack.sr = sr;
                        new_stack.sc = sc;
                        new_stack.er = min(sr+half_r-1, er);
                        new_stack.ec = min(sc+half_c-1, ec);
                end
                new_stack.stage = 0;
                stack(end+1) = new_stack;
            end
            
            continue;
        end
        
        flag1 = stream(idx);
        idx = idx + 1;
        
        if flag1 == 0
            
            bit_plane(sr:er, sc:ec) = 0;
            stack(end) = [];
            continue;
        end
        
        if bsize > 2
            
            flag2 = stream(idx);
            idx = idx + 1;
            
            if flag2 == 0
                
                num_bits = bsize^2;
                data_bits = stream(idx:idx+num_bits-1);
                idx = idx + num_bits;
                
                block = reshape(data_bits, bsize, bsize);
                bit_plane(sr:sr+bsize-1, sc:sc+bsize-1) = block;
                
                stack(end) = [];
                continue;
            end
            
            half = bsize / 2;
            
            stack(end) = [];
            
            for sub = 4:-1:1
                switch sub
                    case 4
                        new_stack.sr = sr + half;
                        new_stack.sc = sc + half;
                        new_stack.er = er;
                        new_stack.ec = ec;
                    case 3
                        new_stack.sr = sr + half;
                        new_stack.sc = sc;
                        new_stack.er = er;
                        new_stack.ec = sc + half - 1;
                    case 2
                        new_stack.sr = sr;
                        new_stack.sc = sc + half;
                        new_stack.er = sr + half - 1;
                        new_stack.ec = ec;
                    case 1
                        new_stack.sr = sr;
                        new_stack.sc = sc;
                        new_stack.er = sr + half - 1;
                        new_stack.ec = sc + half - 1;
                end
                new_stack.stage = 0;
                stack(end+1) = new_stack;
            end
            
            continue;
        end
        
        actual_rows = min(2, er - sr + 1);
        actual_cols = min(2, ec - sc + 1);
        num_bits = actual_rows * actual_cols;
        data_bits = stream(idx:idx+num_bits-1);
        idx = idx + num_bits;
        
        block = reshape(data_bits, actual_rows, actual_cols);
        bit_plane(sr:sr+actual_rows-1, sc:sc+actual_cols-1) = block;
        
        stack(end) = [];
    end
end
