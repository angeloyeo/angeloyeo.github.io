clear; close all; clc;

%% tan(x)=-x�� ������ ã�ƾ� ��.

fun = @(x) tan(x)+x;
my_roots = find_roots(fun, 100);

%%
figure;
fplot(@(x) tan(x), [0, 30],'linewidth',2)
hold on;
fplot(@(x) -x, [0, 30],'color','k')
ylim([-30, 20])
plot(my_roots, -my_roots,'o','markerfacecolor','r','markeredgecolor','k')
grid on;
xlabel('x');
ylabel('y = tan(x) & y = -x');
% title('tan(x)=-x�� solution ã��');
title('finding solutions of tan(x)=-x');
set(gca,'fontname','�������');


%% solution �׷�����


newVid = VideoWriter('pic2', 'MPEG-4'); % New
newVid.FrameRate = 20;
newVid.Quality = 100;
open(newVid);

figure('color','w');
hold on;
xx = linspace(0,1,20);
h(1) = plot(xx, 0.82761 * sin(sqrt(2)*xx)-xx/2,'ro','linewidth',2);

xx = linspace(0, 1, 100);
my_sol = zeros(1, length(xx));
for i = 1:10
    my_sol = my_sol + sin(my_roots(i))*sin(my_roots(i)*xx) / (my_roots(i)^2 * (my_roots(i)^2 - 2) * (1+cos(my_roots(i))^2));
    %     my_sol = my_sol + sin(my_roots(i)) * sin(my_roots(i) * xx) / (my_roots(i)^2*(1+cos(my_roots(i))^2)); % f(x)
    h(2) = plot(xx, 4 * my_sol, 'k','linewidth',2);
    h_legend = legend(h ,'True Solution','Solution using eigenfunctions','location','none','Units','normalized');
    set(h_legend, 'Position',[0.59696, 0.14548, 0.25714, 0.086905])
    title(['n = ',num2str(i)]);
    
    for ii = 1:10
        writeVideo(newVid, getframe(gcf)) % 0.5�ʾ� �׸���
    end
    
    if i < 10
        delete(h(2));
    end
end


for i = 1:30 % ������ ��鿡�� 1.5�� �� ����� �� �ֵ���
    writeVideo(newVid, getframe(gcf))
end

close(newVid)

%% f(x) �׷�����


newVid = VideoWriter('pic3', 'MPEG-4'); % New
newVid.FrameRate = 20;
newVid.Quality = 100;
open(newVid);

figure('color','w');
hold on;
xx = linspace(0,1,20);
h(1) = plot(xx, xx,'ro','linewidth',2);

xx = linspace(0, 1, 100);
my_sol = zeros(1, length(xx));
for i = 1:length(my_roots)
%     my_sol = my_sol + sin(my_roots(i))*sin(my_roots(i)*xx) / (my_roots(i)^2 * (my_roots(i)^2 - 2) * (1+cos(my_roots(i))^2));
    my_sol = my_sol + sin(my_roots(i)) * sin(my_roots(i) * xx) / (my_roots(i)^2*(1+cos(my_roots(i))^2)); % f(x)
    h(2) = plot(xx, 4 * my_sol, 'k','linewidth',2);
    h_legend = legend(h ,'True f(x)','f(x) represented with eigenfunctions','location','none','Units','normalized');
    set(h_legend, 'Position',[0.59696, 0.14548, 0.25714, 0.086905])
    title(['n = ',num2str(i)]);
    
    if i < 10
        for ii = 1:5
            writeVideo(newVid, getframe(gcf))
        end
    else
        if rem(i,2) == 0
            for ii = 1:2
                writeVideo(newVid, getframe(gcf))
            end
        end
    end
    
    if i < length(my_roots)
        delete(h(2));
    end
end


for i = 1:30 % ������ ��鿡�� 1.5�� �� ����� �� �ֵ���
    writeVideo(newVid, getframe(gcf))
end

close(newVid)

%% Ǫ���� �ø���

newVid = VideoWriter('pic4', 'MPEG-4'); % New
newVid.FrameRate = 20;
newVid.Quality = 100;
open(newVid);

figure('color','w');
xx = linspace(0,pi,20);
h(1) = plot(xx, xx,'ro','linewidth',2);
hold on;
xx = linspace(0, pi, 100);
reconstruct = zeros(1, length(xx));
xlim([0, pi])
ylim([0, 4])

for n = 1:1000
    reconstruct = reconstruct + (-1)/n*2*(-1)^n*sin(n*xx);
    h(2) = plot(xx, reconstruct,'linewidth',2,'color','k');
    title(['n = ',num2str(n)]);
    grid on;
    if n < 10
        for ii = 1:5
            writeVideo(newVid, getframe(gcf))
        end
    else
        if rem(n,5) == 0
            for ii = 1:2
                writeVideo(newVid, getframe(gcf))
            end
        end
    end
    
    if n < 1000
        delete(h(2));
    end
end


for i = 1:30 % ������ ��鿡�� 1.5�� �� ����� �� �ֵ���
    writeVideo(newVid, getframe(gcf))
end

close(newVid)