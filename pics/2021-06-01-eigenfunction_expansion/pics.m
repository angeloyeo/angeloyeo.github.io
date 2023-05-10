clear; close all; clc;

xx = linspace(0, 1, 100);
N = 6;

for n = 1:N
    hold on;
    plot(xx, 1/sqrt(2)*sin(n*pi*xx/1));
end

xlabel('$$x$$','interpreter','latex');
ylabel('$$u_n(x)$$','interpreter','latex');
grid on;
title(['�����Լ��� ',num2str(N),'��'])

%%


newVid = VideoWriter('pic2_en', 'MPEG-4'); % New
newVid.FrameRate = 20;
newVid.Quality = 100;
open(newVid);

xx = linspace(0, 1, 100);
f_restored = zeros(1, length(xx));

figure('color','w');
hold on;
for total_n = 1:10
    xx = linspace(0, 1, 100);
    ns = total_n;
    ns(ns==0) = [];
    
    for i_ns = 1:length(ns)
        n = ns(i_ns);
        c_n = -1*(sqrt(2)) * (-1)^n / (n^3*pi^3);
        f_restored = f_restored + c_n * sqrt(2) * sin(n*pi*xx/1);
    end
    
    h = plot(xx, f_restored,'k','linewidth',2);
    
    xx = linspace(0, 1, 20);
    h2 = plot(xx, xx.*(1-xx.^2)/6,'o','markerfacecolor','r','markeredgecolor','k');
    grid on;
    xlabel('x');
    ylabel('u(x)')
%     h_legend = legend([h,h2],'�����Լ� solution','True Solution','location','none','Units','normalized');
    h_legend = legend([h,h2],'Solution with eigenfunctions','True Solution','location','none','Units','normalized');
    set(h_legend, 'Position',[0.59696, 0.14548, 0.25714, 0.086905])
    title(['n = ',num2str(total_n)]);
    for i = 1:10
        writeVideo(newVid, getframe(gcf)) % 0.5�ʾ� �׸���
    end

    if total_n < 10
        delete(h)
    end
end

for i = 1:30 % ������ ��鿡�� 1.5�� �� ����� �� �ֵ���
    writeVideo(newVid, getframe(gcf))
end

close(newVid)