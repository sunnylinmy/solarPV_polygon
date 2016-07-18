clear;
clc;

% data = xlsread('polygonVertices_LatitudeLongitude.csv');
% 
% coordinates = data(:,18);
% jsonmesh = struct('coordinates',coordinates);
% savejson('',jsonmesh,'LonLat');
% 
% jsonmesh2 = struct('type','Polygon','coordinates',coordinates);
% A = savejson('',jsonmesh2,'LonLat2');

load('SolarArrayPolygons20160516.mat');

coordinates = data(:,18);

for i = 1:length(coordinates)
   if coordinates{i}(1,1) ~= coordinates{i}(end,1) | coordinates{i}(1,2) ~= coordinates{i}(end,2)
       coordinates{i}= [coordinates{i};coordinates{i}(1,:)];
   end
end


jsonmesh3 = struct([]);
for i = 1:length(coordinates)
   if size(coordinates{i},1)<=1
       jsonmesh3_add = struct('type','Point','coordinates',coordinates(i));
   else
       jsonmesh3_add = struct('type','Polygon','coordinates',{coordinates(i)});
   end
    jsonmesh3_add2 = struct('type','Feature','geometry',jsonmesh3_add);
    jsonmesh3 = [jsonmesh3;jsonmesh3_add2];
end

%A2 = savejson('',jsonmesh3,'LonLat3.json');
jsonmesh4 = struct('type','FeatureCollection','features',{jsonmesh3});
B= savejson('',jsonmesh4,'LonLat_final.json');