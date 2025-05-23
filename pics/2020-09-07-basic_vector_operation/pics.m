clear; close all; clc;
% addpath('D:\angeloyeo.github.io\MATLAB\다른사람참고code\Annotate-v1.2.1\Annotate\');
% addpath('C:\angeloyeo.github.io\MATLAB\다른사람참고code\Annotate-v1.2.1\Annotate\');
addpath('E:\angeloyeo.github.io\MATLAB\다른사람참고code\Annotate-v1.2.1\Annotate\');

%% pic1

% x 축 원래 axis

theta = 10 / 180 * pi;
mtx_rot = [cos(theta), -sin(theta); sin(theta), cos(theta)];
mtx_rot_inv = inv(mtx_rot);

x_cha_stt = mtx_rot * [-1.5; 0];
x_cha_end = mtx_rot * [8; 0];
y_cha_stt = mtx_rot * [0; -1.5];
y_cha_end = mtx_rot * [0; 8];

vec_ori = [3; 4];
vec_changed = mtx_rot_inv * vec_ori;

figure('color','w');
hold on;
set(gca,'Visible','off')
xlim([-2, 9])
ylim([-2, 9])

Annotate(gca,'arrow', [-1.5, 8], [0, 0]);
Annotate(gca,'arrow', [0, 0], [-1.5, 8]);

for i = -1:7
    if i~=0
        line([i ,i], [-0.1, 0.1],'color','k')
        text(i, -0.3, num2str(i),'HorizontalAlignment','center');
    end
end

for i = -1:7
    if i~= 0
        line([-0.1, 0.1], [i ,i], 'color','k')
        text(-0.3, i, num2str(i),'HorizontalAlignment','center');
    end
end

Annotate(gca,'arrow', [x_cha_stt(1), x_cha_end(1)], [x_cha_stt(2), x_cha_end(2)]);
Annotate(gca,'arrow', [y_cha_stt(1), y_cha_end(1)], [y_cha_stt(2), y_cha_end(2)]);

h_vec = Annotate(gca,'arrow', [0, 3], [0, 4]);
h_vec.Primitive.LineWidth = 2;
h_vec.Primitive.Color = [1, 0, 0];

text(3.0818, 4.3959, '$$\vec{v} = 3\hat{i} + 4\hat{j}$$','interpreter','latex','fontsize',15)
text(3.6, 3.3959, ['$$= ',sprintf('%.1f',vec_changed(1)),'\hat{i}_{new} + ',sprintf('%.1f',vec_changed(2)),'\hat{j}_{new}$$'],'interpreter','latex','fontsize',15)

% xlabel on original axis
text(7.9228, -0.51633, '$$x$$','interpreter','latex','fontsize',12);
text(-0.24401, 8.3105, '$$y$$','interpreter','latex','fontsize',12);
text(7.8173, 1.821,'$$x_{new}$$','interpreter','latex','fontsize',12);
text(-2.038, 8.4708, '$$y_{new}$$','interpreter','latex','fontsize',12);

% 새로운 좌표계에 정사영
linetip = [3; 4];
onto = mtx_rot * [vec_changed(1); 0];
line([linetip(1), onto(1)], [linetip(2), onto(2)],'color','k','linestyle','--')

onto = mtx_rot * [0; vec_changed(2)];
line([linetip(1), onto(1)], [linetip(2), onto(2)],'color','k','linestyle','--')

% saveas(gcf,'pic1.png');

%% 벡터의 스칼라배

newVid = VideoWriter('pic2', 'MPEG-4'); % New
newVid.FrameRate = 20;
newVid.Quality = 100;
open(newVid);

c = sin(linspace(0, 2*pi, 100)) + 2;


figure('color','w');
hold on;
set(gca,'Visible','off')
xlim([-2, 9])
ylim([-2, 9])

Annotate(gca,'arrow', [-1.5, 8], [0, 0]);
Annotate(gca,'arrow', [0, 0], [-1.5, 8]);

for i = -1:7
    if i~=0
        line([i ,i], [-0.1, 0.1],'color','k')
        text(i, -0.3, num2str(i),'HorizontalAlignment','center');
    end
end

for i = -1:7
    if i~= 0
        line([-0.1, 0.1], [i ,i], 'color','k')
        text(-0.3, i, num2str(i),'HorizontalAlignment','center');
    end
end

% xlabel on original axis
text(7.9228, -0.51633, '$$x$$','interpreter','latex','fontsize',12);
text(-0.24401, 8.3105, '$$y$$','interpreter','latex','fontsize',12);


for i = 1:length(c)
    h = Annotate(gca,'arrow',[0, c(i)],[0, c(i)]);
    h.Primitive.Color = [1, 0, 0];
    h.Primitive.LineWidth = 2;

    writeVideo(newVid, getframe(gcf))
    drawnow
    
    if i< length(c)
        delete(h);
    end
end

close(newVid)

%% 벡터의 합 그림


figure('color','w');
hold on;
set(gca,'Visible','off')
xlim([-2, 9])
ylim([-2, 9])

Annotate(gca,'arrow', [-1.5, 8], [0, 0]);
Annotate(gca,'arrow', [0, 0], [-1.5, 8]);

for i = -1:7
    if i~=0
        line([i ,i], [-0.1, 0.1],'color','k')
        text(i, -0.3, num2str(i),'HorizontalAlignment','center');
    end
end

for i = -1:7
    if i~= 0
        line([-0.1, 0.1], [i ,i], 'color','k')
        text(-0.3, i, num2str(i),'HorizontalAlignment','center');
    end
end


% xlabel on original axis
text(7.9228, -0.51633, '$$x$$','interpreter','latex','fontsize',12);
text(-0.24401, 8.3105, '$$y$$','interpreter','latex','fontsize',12);

Annotate(gca,'arrow', [0, 3], [0, 1]);
Annotate(gca,'arrow', [0, 1], [0, 3]);
h =Annotate(gca,'arrow', [0, 4], [0, 4]);
h.Primitive.LineWidth = 2;
h.Primitive.Color = [1, 0, 0];

h = Annotate(gca,'line', [3, 4], [1, 4]);
h.Primitive.LineStyle = '--';
h = Annotate(gca,'line', [1, 4], [3, 4]);
h.Primitive.LineStyle = '--';

text(3.2592, 1.0306,'$$\vec{a}$$','interpreter','latex','fontsize',15)
text(0.59793, 3.4038,'$$\vec{b}$$','interpreter','latex','fontsize',15)
text(4.2224, 4.6866,'$$\vec{a}+\vec{b}$$','interpreter','latex','fontsize',15)

% saveas(gcf,'pic3.png')
%% 2차원 벡터공간 span animation


figure('color','w');
hold on;

set(gca,'Color',[120, 120, 120]/255)
xlabel('$$x$$', 'interpreter','latex');
ylabel('$$y$$', 'interpreter','latex');
grid on;

xlim([-4, 4])
ylim([-4, 4])
[X, Y]= meshgrid(-3:3, -3:3);

x = flipud(X(:));
y = flipud(Y(:));

my_color = flipud(parula(length(x)));

newVid = VideoWriter('pic4', 'MPEG-4'); % New
newVid.FrameRate = 5;
newVid.Quality = 100;
open(newVid);

for i = 1:length(x)
    if ~(x(i) == 0 && y(i) == 0)
        hObj = Annotate(gca, 'arrow', [0, x(i)], [0, y(i)]);
        hObj.Primitive.Color = my_color(i, :);
        hObj.Primitive.LineWidth = 2;
        
        writeVideo(newVid, getframe(gcf))
        drawnow
    end
end

for i =1:newVid.FrameRate % 1초 정도만 마지막 장면을 늘리는것으로
    writeVideo(newVid, getframe(gcf))
end

close(newVid)
