clear; close all; clc;

%% Vector in XY plane
addpath("../arrow/")
plotXYPlane()
hold on;
xgrid = linspace(-1, 1, 7);
ygrid = linspace(1, -1, 7);
[X, Y] = ndgrid(xgrid, ygrid);

X = X(:); Y = Y(:);
cmap = flipud(jet(numel(X)));
h = zeros(1, numel(X));

v = VideoWriter('vector2dot.mp4', 'MPEG-4');
v.FrameRate = 30; % 프레임 속도 설정 (초당 프레임 수)
open(v);

for idx = 1:numel(X)
    h(idx) = arrow([0, 0], [X(idx), Y(idx)], 'color', cmap(idx,:), 'linewidth', 1, 'EdgeColor', 'k');
    drawnow;
    frame = getframe(gcf);
    writeVideo(v, frame);
end

for idx = 1:numel(X)
    delete(h(idx));
    scatter(X(idx), Y(idx), 100, cmap(idx,:), "filled","MarkerEdgeColor", "k", "linewidth", 1.5);
    drawnow;

    frame = getframe(gcf);
    writeVideo(v, frame);
end

for i = 1:30 % dummy frame at the end
    frame = getframe(gcf);
    writeVideo(v, frame);
end
close(v);

%% dots to picture
plotXYPlane()
hold on;
scatter(X, Y, 100, cmap, "filled","MarkerEdgeColor", "k", "linewidth", 1.5);

%% 2D Transformation
% what_transform = "permutation";
% what_transform = "rotation";
what_transform = "shear";

switch what_transform
    case "rotation"
        q = pi/3;
        mtx = [cos(q), -sin(q); 
            sin(q), cos(q)];
    case "shear"
        mtx = [2, 1; 1, 2];
    case "permutation"
        mtx = [0, 1; 1, 0];
end
v = VideoWriter("2d_"+what_transform+".mp4", "MPEG-4");
open(v);
plotXYPlane()
set(gcf,'position', [-669.0000  422.3333  530.6667  356.6667]);
hold on;
img = imread('cameraman.tif');
img = flipud(img);
img_rgb = ind2rgb(img, gray(256));

% Create a grid for the warp function
[Xq_original, Yq_original] = meshgrid(linspace(min(X), max(X), size(img, 2)), ...
    linspace(min(Y), max(Y), size(img, 1)));

n_steps = 100;
for i_step = 0:n_steps

    temp_Mtx = (mtx - eye(2)) * i_step/n_steps + eye(2);
    
    % Plot the change of a picture on the top surface
    tempXYq = [Xq_original(:), Yq_original(:)]';
    tempXYq = temp_Mtx * tempXYq;
    Xq = reshape(tempXYq(1,:), size(Xq_original));
    Yq = reshape(tempXYq(2,:), size(Xq_original));

    % Warp the image onto the top face
    h = warp(Xq, Yq, zeros(size(Xq)), img_rgb);
    set(gca, "YDir", "normal");
    view(2)
    drawnow;
    frame = getframe(gcf);
    writeVideo(v, frame);
    if i_step < n_steps
        delete(h);
    end
end


for i = 1:30
    frame = getframe(gcf);
    writeVideo(v, frame)
end

close(v);

%% 3D Transformation

% what_transform = "rotation";
what_transform = "shear";
% what_transform = "reflection";

switch what_transform
    case "rotation"
        q = pi/3;
        mtx = [cos(q), -sin(q), 0; 
            sin(q), cos(q), 0;
            0,0,1];
    case "shear"
        mtx = [...
            2, 1, 0; 
            0, 2, 0; 
            0, 0, 1];
    case "reflection"
        mtx = [0, 1, 0;
            1, 0, 0;
            0, 0, 1];
    case "projection"
        q = pi/3;
        mtx = [cos(q) -sin(q) 0; ...
     sin(q)  cos(q) 0; ...
     0.001        0.001       1];
end

v = VideoWriter("3d_"+what_transform+".mp4", "MPEG-4");
open(v);

addpath("..\plotframe\");
f = figure('color','w');
axes(f, "DataAspectRatio", [1,1,1], "view", [37.5, 30]);

rotationMatrix = eye(3);
translationVector = [0,0,0];
basisVectorLenghts = 5 * ones(1,3);

plotframe(rotationMatrix, translationVector, basisVectorLenghts, ...
    "BasisColor", [.4, .4, .4; .6, .6, .6; .8, .8, .8], ...
    "LabelBasis", true, "Labels", {'x', 'y', 'z'},...
    "TextProperties", {'FontAngle', 'italic'},...
    "Alignment", "center", "Marker", "o", "markersize", 6, ...
    "LineStyle", "-.", "MarkerFaceColor", "k", "MarkerEdgeColor", "k");

grid on;
hold on;

% Adjust the view
% view(3);
axis equal;
xlabel('X');
ylabel('Y');
zlabel('Z');

xlim([-3 3]);
ylim([-3 3]);
zlim([-3 3]);

% 3D Linear Transofmation

% Define the vertices of the cube
vertices_original = [
    -1 -1 -1;  % Vertex 1
    1 -1 -1;   % Vertex 2
    1  1 -1;   % Vertex 3
    -1  1 -1;  % Vertex 4
    -1 -1  1;  % Vertex 5
    1 -1  1;   % Vertex 6
    1  1  1;   % Vertex 7
    -1  1  1   % Vertex 8
    ];

% Define the faces of the cube
faces = [
    1 2 3 4;  % Face 1
    2 6 7 3;  % Face 2
    5 1 4 8;  % Face 3
    4 3 7 8;  % Face 4
    5 6 2 1   % Face 5
    6 5 8 7;  % Face 6 Head
    ];

img = imread('cameraman.tif');
img = flipud(img);
img_rgb = ind2rgb(img, gray(256));
[~, map] = rgb2ind(img_rgb, 256);

% Define the top face vertices
X = vertices_original(faces(3,:), 1);
Y = vertices_original(faces(3,:), 2);
Z = vertices_original(faces(3,:), 3);

% Create a grid for the warp function
[Xq_original, Yq_original] = meshgrid(linspace(min(X), max(X), size(img, 2)), ...
    linspace(min(Y), max(Y), size(img, 1)));

% Mtx = eye(3);
% Mtx(1,2) = 2;
% Mtx(2,1) = 2;


%

h = zeros(1, 6);

n_steps = 100;
for i_step = 0:n_steps

    temp_Mtx = (mtx - eye(3)) * i_step/n_steps + eye(3);

    vertices = (temp_Mtx * vertices_original')';

    % Plot the other faces of the cube
    for i = 1:5
        h(i) = patch('Vertices', vertices, 'Faces', faces(i,:), ...
            'FaceColor', lines(1), 'EdgeColor', 'black', 'FaceAlpha', 0.3);
    end
    
    % Plot the change of a picture on the top surface
    tempXYq = [Xq_original(:), Yq_original(:), ones(numel(Xq_original), 1)]';
    tempXYq = temp_Mtx * tempXYq;
    Xq = reshape(tempXYq(1,:), size(Xq_original));
    Yq = reshape(tempXYq(2,:), size(Xq_original));
    Zq = reshape(tempXYq(3,:), size(Xq_original));

    % Warp the image onto the top face
    h(3) = warp(Xq, Yq, Zq, img_rgb);
    view([37.5, 30])
    set(gca, "YDir", "normal");

    drawnow;
    frame = getframe(gcf);
    writeVideo(v, frame);

    if i_step < n_steps
        delete(h);
    end
end

for i = 1:30
    frame = getframe(gcf);
    writeVideo(v, frame)
end

hold off;
% view(2)
close(v)

