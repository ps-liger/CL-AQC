function [CBS,type] = BitPlanes_Compress(Plane)

try
    CBS = QuadTree_BDBE_Compress(Plane);
    type = 1;
catch ME
    disp(['[QuadTree BDBE] Error: ' ME.message]);
    CBS = [];
    type = 0;
end
