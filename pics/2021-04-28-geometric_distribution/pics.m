clear; close all; clc;

ps = [0.2, 0.5, 0.8];
my_color = lines(3);

f = @(p, k) p*(1-p).^(k-1);
xx = 1:10;

for i_ps = 1:length(ps)
    p = ps(i_ps);
    Pr(i_ps,:) = f(p, xx);
end

%%
figure;
hold on;
clear h
for i =1:3
    h(i) = plot(xx, Pr(i,:),'o-','markerfacecolor',my_color(i,:),'markeredgecolor','k','color','k','markersize',8,'linewidth',1.2);
end
xlim([0, 10])
grid on;
% xlabel('ó�� ������ ȸ�� k');
xlabel('The number of attepts k to obtain the first success');
ylabel('Pr(K=k)');
ylim([-0.05, 0.85])
% title('���� ������ Ȯ�������Լ�')
title('Probability Mass Function Geometric Distribution')
legend(h, 'p = 0.2', 'p = 0.5', 'p = 0.8');
set(gca,'fontname','�������');
set(gca,'xtick',0:10)
