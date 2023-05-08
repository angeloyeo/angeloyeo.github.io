clear; close all; clc;


newVid = VideoWriter('pic_kalman_main_en', 'MPEG-4'); % New
newVid.FrameRate = 40;
newVid.Quality = 100;
open(newVid);

measurements = [5, 6, 7, 9, 10, 11, 12, 13];
motion = [1, 1, 2, 1, 1, 1, 2, 1];
measurement_sig = 2;
motion_sig = 2;

mu = 0;
sig = 4;

xx = linspace(-2, 15, 1000);
yy1 = normpdf(xx, mu, sig);

my_color = lines(3);
clear h

figure('color','w');
h(1) = plot(xx, yy1,'color',my_color(1,:),'linewidth',2); hold on; % ù Prior
grid on;
xlabel('x');
ylabel('pdf');
xlim([0, 10])
ylim([0, 0.35])
% t = text(0, 0.25, 'ù Prior ����','edgecolor','k','backgroundcolor','w','fontsize',15);
t = text(0, 0.25, 'First Prior','edgecolor','k','backgroundcolor','w','fontsize',15);
legend(h, 'Prior');
set(gca,'fontname','�������')
% title('Į�� ������ �۵�')
title('How Kalman Filter works')
for ii = 1:40
    writeVideo(newVid, getframe(gcf))
end
delete(t)
pause(1)

for i = 1:length(measurements)
    yy2 = normpdf(xx, measurements(i), measurement_sig);
    
    if i>1
        delete(h(2));
        delete(t);
    end
    
    h(2) = plot(xx, yy2,'color',my_color(2,:),'linewidth',2); % measurement ���� ��
    % t = text(0, 0.25, '����','edgecolor','k','backgroundcolor','w','fontsize',15);
    t = text(0, 0.25, 'Measure','edgecolor','k','backgroundcolor','w','fontsize',15);
    legend(h, 'Prior','Measurement');
    
    for ii = 1:40
        writeVideo(newVid, getframe(gcf))
    end
    delete(t)
    pause(1);
    
    [mu, sig] = update(mu, sig, measurements(i), measurement_sig);
    yy1 = normpdf(xx, mu, sig);
    
    if i>1
        delete(h(3));
    end
    
    
    h(3) = plot(xx, yy1,'color',my_color(3,:),'linewidth',2); hold on; % Posterior�� ����.
    % t = text(0, 0.25,'Prior �� Posterior ������Ʈ.','edgecolor','k','backgroundcolor','w','fontsize',15);
    t = text(0, 0.25,'Update Prior to Posterior.','edgecolor','k','backgroundcolor','w','fontsize',15);
    legend(h, 'Prior','Measurement','Posterior');

    for ii = 1:40
        writeVideo(newVid, getframe(gcf))
    end
    delete(t)
    pause(1);
    
%     disp(['Update:',num2str(mu),'/',num2str(sig)]);
    
    [mu, sig] = predict(mu, sig, motion(i), motion_sig);
    yy1 = normpdf(xx, mu, sig);
    
    delete(h(1))
    h(1) = plot(xx, yy1,'color',my_color(1,:),'linewidth',2); hold on; % ���� Prior ������.
    % t = text(0, 0.25, '������ Prior�� �̵�','edgecolor','k','backgroundcolor','w','fontsize',15);
    t = text(0, 0.25, 'To next Prior','edgecolor','k','backgroundcolor','w','fontsize',15);
    legend(h, 'Next Prior','Measurement','Posterior');

    for ii = 1:40
        writeVideo(newVid, getframe(gcf))
    end
    delete(t)
    pause(1);
%     disp(['Predict:',num2str(mu),'/',num2str(sig)]);
end

close(newVid)


function [new_mean, new_var] = predict(mean1, var1, mean2, var2)

new_mean = mean1 + mean2;
new_var = var1 + var2;
% new_var = var1;

end

function [new_mean, new_var] = update(mean1, var1, mean2, var2)

new_mean = (var2 * mean1 + var1 * mean2) / (var1 + var2);
new_var = 1/(1/var1 + 1/var2);

end
