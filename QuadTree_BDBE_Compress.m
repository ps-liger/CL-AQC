function compressed_stream = QuadTree_BDBE_Compress(bit_plane)

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
        sub_streams = cell(1, 4);
        sub_lengths = zeros(1, 4);
        sub_idx = 1;
        for i = 0:1
            for j = 0:1
                r = sr + i * half;
                c = sc + j * half;
                sub_streams{sub_idx} = process_block(plane, r, c, half);
                sub_lengths(sub_idx) = length(sub_streams{sub_idx});
                sub_idx = sub_idx + 1;
            end
        end
        
        direct_store_length = 2 + bsize^2;
        split_length = 2 + sum(sub_lengths);
        
        if split_length < direct_store_length
            stream = [1, 1];
            for sub_idx = 1:4
                stream = [stream, sub_streams{sub_idx}];
            end
        else
            stream = [1, 0, block(:)'];
        end
    else
        stream = [1, block(:)'];
    end
end
