clear
clc

I = imread('测试图像\Jetplane.tiff');

origin_I = double(I); 

num_D = 3000000;
rand('seed',0); 
D = round(rand(1,num_D)*1); 

K_en = 1; 
K_hide=3; 

[ES_I,num_Of,PL_len,PL_room,total_Room,best_code,transform_code_bits] = Vacate_Encrypt(origin_I,K_en);


[row,col] = size(origin_I); 
num = ceil(log2(row))+ceil(log2(col))+2; 

if total_Room>=num 
    
    [stego_I,emD] = Data_Embed(ES_I,K_hide,D); 
    num_emD = length(emD);
    
    [exD] = Data_Extract(stego_I,K_hide,num_emD);
    
    [recover_I] = Image_Recover(stego_I,K_en);
    

    
    
    [m,n] = size(origin_I);
    bpp = num_emD/(m*n);
    
    check1 = isequal(emD,exD);
    check2 = isequal(origin_I,recover_I);
    if check1 == 1
        disp('Extracted data is completely identical to embedded data')
    else
        disp('Warning: Data extraction error')
    end
    if check2 == 1
        disp('Reconstructed image is completely identical to original image')
    else
        disp('Warning: Image reconstruction error')
    end
    
    psnr_encrypted = PSNR(origin_I, ES_I);
    ssim_encrypted = SSIM(origin_I, ES_I);
    
    psnr_stego = PSNR(origin_I, stego_I);
    ssim_stego = SSIM(origin_I, stego_I);
    
    entropy_origin = Entropy(origin_I);
    entropy_encrypted = Entropy(ES_I);
    entropy_stego = Entropy(stego_I);
    
    [cc_h_origin, cc_v_origin, cc_d_origin] = CorrelationCoefficient(origin_I);
    [cc_h_encrypted, cc_v_encrypted, cc_d_encrypted] = CorrelationCoefficient(ES_I);
    [cc_h_stego, cc_v_stego, cc_d_stego] = CorrelationCoefficient(stego_I);
    
    uaci_encrypted = UACI(origin_I, ES_I);
    uaci_stego = UACI(origin_I, stego_I);
    
    
    if check1 == 1 && check2 == 1
        disp(['Embedding capacity equal to : ' num2str(num_emD) ' bits'] )
        disp(['Embedding rate equal to : ' num2str(bpp) ' bpp'])
        fprintf(['This test image------------ OK','\n\n']);
    else
        fprintf(['This test image------------ ERROR','\n\n']);
    end  
    
end