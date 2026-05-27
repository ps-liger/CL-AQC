# CL-AQC
Implementation of a high-capacity RDHEI method based on prediction-error mapping and code-length-adaptive quadtree coding.
# CL-AQC: Reversible Data Hiding in Encrypted Images with Transform and Prediction Error

## Project Introduction

CL-AQC is a MATLAB-based system for reversible data hiding in encrypted images. This system supports:
- Image encryption
- Large-capacity data hiding
- Complete image recovery and data extraction
- Multiple image quality evaluation metrics

## File Structure

```
CL-AQC/
├── 测试图像/              # Test images folder
│   ├── Airplane.tiff
│   ├── Baboon.tiff
│   ├── Jetplane.tiff
│   ├── Lena.tiff
│   ├── Man.tiff
│   ├── Peppers.tiff
│   └── Tiffany.tiff
├── Main.m                  # Main program entry
├── Vacate_Encrypt.m        # Image encryption and room vacating
├── Data_Embed.m            # Data embedding
├── Data_Extract.m          # Data extraction
├── Image_Recover.m         # Image recovery
├── Image_Transform.m       # Image transform
├── Image_Inverse_Transform.m  # Image inverse transform
├── Prediction_Error.m      # Prediction error calculation
├── Vacate_Room.m           # Room vacating
├── Data_Encrypt.m          # Data encryption
├── BitPlanes_Compress.m    # Bit plane compression
├── BitPlanes_Embed.m       # Bit plane embedding
├── BitPlanes_Extract.m     # Bit plane extraction
├── QuadTree_BDBE_Compress.m    # QuadTree BDBE compression
├── QuadTree_BDBE_DeCompress.m  # QuadTree BDBE decompression
├── QuadTree_Fixed_Compress.m   # QuadTree fixed compression
├── BinaryConversion_10_2.m     # Decimal to binary conversion
├── BinaryConversion_2_10.m     # Binary to decimal conversion
├── PSNR.m                  # Peak Signal-to-Noise Ratio calculation
├── SSIM.m                  # Structural Similarity calculation
├── Entropy.m               # Entropy calculation
├── CorrelationCoefficient.m    # Correlation coefficient calculation
├── UACI.m                  # Unified Average Changing Intensity calculation
└── GetHis.m                # Histogram acquisition
```

## Usage

1. Run `Main.m` to start the program
2. Modify parameters in `Main.m`:
   - `I`: Input image path
   - `num_D`: Number of bits to embed
   - `K_en`: Encryption key
   - `K_hide`: Data hiding key

## Main Features

### 1. Image Encryption
Implements image security protection through image transform, prediction error calculation, and stream cipher encryption.

### 2. Data Hiding
Hides large amounts of secret data in encrypted images, supporting high-capacity embedding.

### 3. Reversible Recovery
Can completely recover the original image and extract hidden data without any information loss.

### 4. Quality Evaluation
Built-in evaluation metrics:
- PSNR (Peak Signal-to-Noise Ratio)
- SSIM (Structural Similarity Index)
- Entropy (Information entropy)
- Correlation Coefficient
- UACI (Unified Average Changing Intensity)

## System Requirements

- MATLAB R2016b or higher
- Image Processing Toolbox

