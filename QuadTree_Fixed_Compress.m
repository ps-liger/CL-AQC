function compressed_stream = QuadTree_Fixed_Compress(bit_plane)

[row, col] = size(bit_plane);
compressed_stream = process_block(bit_plane, 1, 1, min(row, col));
end

function stream = process_block(plane, sr, sc, bsize)
    stream = [];
    
    if bsize > 16
        half = bsize / 2;
        for i = 0:1
            for j = 0:1
                r = sr + i * half;
                c = sc + j * half;
                sub_stream = process_block(plane, r, c, half);
                stream = [stream, sub_stream];
            end
        end
        return;
    end
    
    block = plane(sr:sr+bsize-1, sc:sc+bsize-1);
    
    if all(block(:) == 0)
        stream = 0;
        return;
    end
    
    if bsize > 2
        half = bsize / 2;
        stream = 1;  % 标记非全零
        for i = 0:1
            for j = 0:1
                r = sr + i * half;
                c = sc + j * half;
                sub_stream = process_block(plane, r, c, half);
                stream = [stream, sub_stream];
            end
        end
    else
        stream = [1, block(:)'];  % 标记非全零，存储2x2块
    end
end
