clear; close all; clc;

%% ���� ���� �׸���

n = 10;
p = 0.5;
x = 0:n;

f = @(x, n, p) factorial(n)./(factorial(x).*factorial(n-x)) .* p.^x .* (1-p).^(n-x);

my_color = lines(3);
stem(x, f(x, n, p), 'o' ,'markerfacecolor',my_color(1,:),'linewidth',2);
xlabel('���� Ƚ��(k)');
ylabel('probability, Pr(K=k)');
grid on;
title(['binomial distribution PMF',' / n: ',num2str(n),', p: ',num2str(p)]);

%% ���� ���� �ùķ��̼�

n_sim = 100;
rng(8)
% n_sim = 1000;
res_sim = zeros(1, n_sim);
for i_sim = 1:n_sim
    count = 0;
    for i = 1:n
        if rand(1) < p
            count = count + 1;
        end
    end
    res_sim(i_sim) = count;
end
figure;
histogram(res_sim);

% figure; histogram(res_sim,'Normalization','pdf');
% hold on;
% stem(x, f(x, n, p), 'o' ,'markerfacecolor',my_color(1,:));

%% simulation + discrete histogram���� ...


newVid = VideoWriter('pic2_en', 'MPEG-4'); % New
newVid.FrameRate = 10;
newVid.Quality = 100;
open(newVid);

figure('color','w');
hold on;
count = zeros(1, 11);
% stem(x, f(x, n, p) * n_sim, 'o' ,'markerfacecolor',my_color(1,:),'linewidth',2);

for i_data = 1:length(res_sim)
    count(res_sim(i_data)+1) = count(res_sim(i_data)+1) + 1;
    
    plot(res_sim(i_data), count(res_sim(i_data)+1),'o','markerfacecolor',...
        0.8 * ones(1,3),'markeredgecolor','k','markersize',10);
    h2del = plot(res_sim(i_data), count(res_sim(i_data)+1),'o','markerfacecolor',...
        [255, 177, 51]/255,'markeredgecolor','k','markersize',10);
    ylim([0, 25])
    xlim([0, 10])
    % xlabel('10�� �� �ո��� ���� Ƚ��(k)');
    xlabel('Count of head out of 10(k)');
    % ylabel('��');
    ylabel('Frequency');
    % title(['������ ���׺��� / n: ',num2str(n),', p: ',num2str(p)])
    title(['Empirical Binomial Dist. / n: ',num2str(n),', p: ',num2str(p)])
    
    grid on;
    
    writeVideo(newVid, getframe(gcf))
    pause(0.1);
    delete(h2del)
end


for i = 1:30 % ������ ��鿡�� 1.5�� �� ����� �� �ֵ���
    writeVideo(newVid, getframe(gcf))
end

close(newVid)



