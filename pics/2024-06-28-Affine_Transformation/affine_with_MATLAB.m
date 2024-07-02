clear;
close all; clc;
cb = checkerboard;
imshow(cb)
cb_ref = imref2d(size(cb));
tx = 20; % x축 이동
ty = 30; % y축 이동
T = [1 0 tx; 0 1 ty; 0 0 1];
theta = 30; % 30도 회전
R = [cosd(theta) -sind(theta) 0; sind(theta) cosd(theta) 0; 0 0 1];
TR = T * R; % 이동 후 회전
n_steps = 100;
for i_step = 0:n_steps
    temp_TR = (TR-eye(3)) * i_step/n_steps + eye(3);
    tform_tr = affinetform2d(temp_TR);
    [out, out_ref] = imwarp(cb, cb_ref, tform_tr);
    imshowpair(out, out_ref, cb, cb_ref, 'montage');

    drawnow;
    if i_step<n_steps
        cla;
    end
end