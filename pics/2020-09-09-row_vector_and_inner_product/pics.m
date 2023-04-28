clear; close all; clc;
addpath('C:\angeloyeo.github.io\pics\2020-09-09-row_vector_and_inner_product\Annotate-v1.2.3\Annotate');

%% �� ���� subplot�� �� ������ ���͵� �׷��ֱ�
figure('position',[680, 560, 1080, 420])

subplot(1,2,1)
xlim([-1.5, 1.5])
ylim([-1.5, 1.5])
h = Annotate(gca,'arrow', [0, 1], [0, 0]);
h.Primitive.Color = [0, 0.447, 0.741];
h.Primitive.LineWidth = 2;
text(0.724, -0.159,'(1, 0)','interpreter','latex','fontsize',15,'color', [0, 0.447, 0.741],'FontWeight','bold');

h = Annotate(gca,'arrow', [0, 0.5], [0, 1]);
h.Primitive.Color = [0.85, 0.325, 0.098];
h.Primitive.LineWidth = 2;
text(-0.184, 0.88,'(0.5, 1)','interpreter','latex','fontsize',15,'color',[0.85, 0.325, 0.098],'FontWeight','bold');
grid on;
title('���� ������ �� ����')

subplot(1,2,2)
xlim([-1.5, 1.5])
ylim([-1.5, 1.5])
h = Annotate(gca,'arrow', [0, 1], [0, 0]);
h.Primitive.Color = [0, 0.447, 0.741];
h.Primitive.LineWidth = 2;
text(0.724, -0.159,'(1, 0)','interpreter','latex','fontsize',15,'color', [0, 0.447, 0.741],'FontWeight','bold');

h = Annotate(gca,'arrow', [0, 0], [0, 1]);
h.Primitive.Color = [0.85, 0.325, 0.098];
h.Primitive.LineWidth = 2;
text(-0.549, 0.899,'(0, 1)','interpreter','latex','fontsize',15,'color',[0.85, 0.325, 0.098],'FontWeight','bold');
grid on;
title('�����ϴ� �� ����')

%% �� ���� subplot�� �� ������ ���͵� �׷��ֱ�
figure('position',[680, 560, 1080, 420])

subplot(1,2,1)
xlim([-3, 3])
ylim([-3, 3])
h = Annotate(gca,'arrow', [0, 1], [0, 0]);
h.Primitive.Color = [0, 0.447, 0.741];
h.Primitive.LineWidth = 2;
text(0.044, -0.264,'(1, 0)','interpreter','latex','fontsize',15,'color', [0, 0.447, 0.741],'FontWeight','bold');

h = Annotate(gca,'arrow', [0, 0.5], [0, 1]);
h.Primitive.Color = [0.85, 0.325, 0.098];
h.Primitive.LineWidth = 2;
text(-0.765, 0.505,'(0.5, 1)','interpreter','latex','fontsize',15,'color',[0.85, 0.325, 0.098],'FontWeight','bold');
title('���� ������ �� ����')
hold on;
for i = -4:4
    xx = linspace(-3, 3, 10);
    yy = 2 * xx + 2 * i;
    plot(xx, yy, 'k--');
end

for i = -4:4
    xx = linspace(-3, 3, 10);
    yy = i * ones(1,length(xx));
    plot(xx, yy, 'k--');
end


subplot(1,2,2)
xlim([-3, 3])
ylim([-3, 3])
h = Annotate(gca,'arrow', [0, 1], [0, 0]);
h.Primitive.Color = [0, 0.447, 0.741];
h.Primitive.LineWidth = 2;
text(0.092, -0.317,'(1, 0)','interpreter','latex','fontsize',15,'color', [0, 0.447, 0.741],'FontWeight','bold');

h = Annotate(gca,'arrow', [0, 0], [0, 1]);
h.Primitive.Color = [0.85, 0.325, 0.098];
h.Primitive.LineWidth = 2;
text(-0.865, 0.478,'(0, 1)','interpreter','latex','fontsize',15,'color',[0.85, 0.325, 0.098],'FontWeight','bold');
title('�����ϴ� �� ����')
hold on;

for i = -4:4
    xx = linspace(-3, 3, 10);
    yy = i * ones(1,length(xx));
    plot(xx, yy, 'k--');
    plot(yy,xx,'k--');
end

%% 
figure('color','w','position',[680, 300, 480, 480]);
hold on;
set(gca,'Visible','off')
xlim([-4, 4])
ylim([-4, 4])

Annotate(gca,'arrow', [-4, 4], [0, 0]);
Annotate(gca,'arrow', [0, 0], [-4, 4]);

for i = -4:3
    if i~=0
        line([i ,i], [-0.1, 0.1],'color','k')
        text(i, -0.3, num2str(i),'HorizontalAlignment','center');
    end
end

for i = -4:3
    if i~= 0
        line([-0.1, 0.1], [i ,i], 'color','k')
        text(-0.3, i, num2str(i),'HorizontalAlignment','center');
    end
end

% xlabel on original axis
text(3.9228, -0.3, '$$x$$','interpreter','latex','fontsize',12);
text(-0.3, 3.8105, '$$y$$','interpreter','latex','fontsize',12);

% �������� �׸���
h = Annotate(gca,'arrow', [0, 1], [0, 0]);
h.Primitive.Color = [1, 0, 0];
h.Primitive.LineWidth = 2;
text(0.35, -0.25,'$$\hat{i}$$','interpreter','latex','fontsize',12,'color','r','FontWeight','bold');

h = Annotate(gca,'arrow', [0, 0], [0, 1]);
h.Primitive.Color = [1, 0, 0];
h.Primitive.LineWidth = 2;
text(-0.25, 0.6,'$$\hat{j}$$','interpreter','latex','fontsize',12,'color','r','FontWeight','bold');

% line�� �׷��ֱ�
xx = linspace(-6, 6, 100);

for i = -3:4
    plot(xx, -2 * xx + i,'k--');
    % 2x+y = 1
    % 2x = 1- y
    % x = (1-y)/2
    
    text((i-2.5)/2  + 0.1, 2.5, num2str(i),'color',[1, 0, 0],'FontWeight','Bold');
end

xlim([-3, 3])
ylim([-3, 3])

%% ����� ��ġ�� ���� ���� �׷��ֱ�
ontos = [-3, -1, 0, 1, 3, 4];
my_color = lines(length(ontos));
figure('color','w','position',[680, 300, 1000, 680]);
ii=1;
for i_onto = 1:length(ontos)
    subplot(2,3, ii);
    hold on;
    set(gca,'Visible','off')
    xlim([-3, 3])
    ylim([-3, 3])
    
    Annotate(gca,'arrow', [-3, 3], [0, 0]);
    Annotate(gca,'arrow', [0, 0], [-3, 3]);
    
    for i = -3:2
        if i~=0
            line([i ,i], [-0.1, 0.1],'color','k')
            text(i, -0.3, num2str(i),'HorizontalAlignment','center');
        end
    end
    
    for i = -3:2
        if i~= 0
            line([-0.1, 0.1], [i ,i], 'color','k')
            text(-0.3, i, num2str(i),'HorizontalAlignment','center');
        end
    end
    
    % xlabel on original axis
    text(2.9228, -0.3, '$$x$$','interpreter','latex','fontsize',12);
    text(-0.3, 2.8105, '$$y$$','interpreter','latex','fontsize',12);
    
    % line�� �׷��ֱ�
    xx = linspace(-6, 6, 100);
    
    for i = -3:4
        plot(xx, -2 * xx + i,'k--');
        
        text((i-2.5)/2  + 0.1, 2.5, num2str(i),'color',[1, 0, 0],'FontWeight','Bold');
        
    end
    onto = ontos(i_onto);
    
    x2see = linspace(-3, 3, 10);
    y2see = -2 * x2see + onto;
    
    for i2see = 1:length(x2see)
        if abs(x2see(i2see)) <= 3 && abs(y2see(i2see)) <= 3
            h = Annotate(gca,'arrow',[0, x2see(i2see)],[0, y2see(i2see)]);
            %         h.Primitive.Color = [1, 0, 0];
            h.Primitive.Color = my_color(i_onto,:);
            h.Primitive.LineWidth= 2;
        end
    end
    
    % title ���ֱ�
    % text(0, 3.5, ['��°��� ',num2str(onto),'�� ���͵�'],'HorizontalAlignment','center')
    text(0, 3.5, ['Vectors with ouputs equal to ',num2str(onto)],'HorizontalAlignment','center')
    
    ii=ii+1;
end

%% ��Į�� ����� 4�� ��쿡 ���� ������ ���� �ϳ��� ��ƺ���.
my_color = lines(6);
figure('color','w','position',[680, 300, 480, 480]);
hold on;
set(gca,'Visible','off')
xlim([-3, 3])
ylim([-3, 3])

Annotate(gca,'arrow', [-3, 3], [0, 0]);
Annotate(gca,'arrow', [0, 0], [-3, 3]);

for i = -3:2
    if i~=0
        line([i ,i], [-0.1, 0.1],'color','k')
        text(i, -0.3, num2str(i),'HorizontalAlignment','center');
    end
end

for i = -3:2
    if i~= 0
        line([-0.1, 0.1], [i ,i], 'color','k')
        text(-0.3, i, num2str(i),'HorizontalAlignment','center');
    end
end

% xlabel on original axis
text(2.9228, -0.3, '$$x$$','interpreter','latex','fontsize',12);
text(-0.3, 2.8105, '$$y$$','interpreter','latex','fontsize',12);

% line�� �׷��ֱ�
xx = linspace(-6, 6, 100);

for i = -3:4
    plot(xx, -2 * xx + i,'k--');
    
    text((i-2.5)/2  + 0.1, 2.5, num2str(i),'color',[1, 0, 0],'FontWeight','Bold');
end

onto = 4;

x2see = linspace(-3, 3, 10);
y2see = -2 * x2see + onto;

for i2see = 1:length(x2see)
    if abs(x2see(i2see)) <= 3 && abs(y2see(i2see)) <= 3
        h = Annotate(gca,'arrow',[0, x2see(i2see)],[0, y2see(i2see)]);
        %         h.Primitive.Color = [1, 0, 0];
        h.Primitive.Color = my_color(6,:);
        h.Primitive.LineWidth= 2;
        break; % ó���� ������ ���� ���Ⱑ ���� ���� �ϳ��� �׸��� ����.
    end
end

% �຤�Ϳ� y=-2x+4������ �Ÿ����� plot�ϴ� ���
h = Annotate(gca,'arrow',[0, 2], [0, 1]);
h.Primitive.Color = [0, 0, 1];
h.Primitive.LineWidth = 2;

h = Annotate(gca,'line', [0, 8/5],[0, 4/5]);
h.Primitive.Color = [1, 0, 0];
h.Primitive.LineWidth = 2;
text(2.0087, 1.1816, '(2, 1)')
% title ���ֱ�
% text(0, 3.3, ['��°��� ',num2str(onto),'�� ���� �� �ϳ�'],'HorizontalAlignment','center','fontsize',12)
text(0, 3.3, ['One of vectors with output equals to ',num2str(onto)],'HorizontalAlignment','center','fontsize',12)

%% 2x+y=4�� ����̰� x=0~2������ ���� ǥ���� �׸��ϳ� �׸� ��.
figure('color','w','position',[680, 300, 300, 480]);
hold on;
set(gca,'Visible','off')
xlim([-1, 3])
ylim([-1, 5])

Annotate(gca,'arrow', [-1, 3], [0, 0]);
Annotate(gca,'arrow', [0, 0], [-1, 5]);

for i = 0:2
    if i~=0
        line([i ,i], [-0.1, 0.1],'color','k')
        text(i, -0.3, num2str(i),'HorizontalAlignment','center');
    end
end

for i = 0:4
    if i~= 0
        line([-0.1, 0.1], [i ,i], 'color','k')
        text(-0.3, i, num2str(i),'HorizontalAlignment','center');
    end
end

% xlabel on original axis
text(2.9228, -0.3, '$$x$$','interpreter','latex','fontsize',12);
text(-0.3, 4.8105, '$$y$$','interpreter','latex','fontsize',12);

% ���� 2x+y=4 �׷��ֱ�
xx = linspace(0, 2, 100);
plot(xx, -2 * xx + 4,'k--');

h = Annotate(gca,'line', [0, 8/5],[0, 4/5]);
h.Primitive.Color = [1, 0, 0];
h.Primitive.LineWidth = 2;
% title ���ֱ�


%% row vector �Լ� �ð�ȭ���� scaling

newVid = VideoWriter('pic10', 'MPEG-4'); % New
newVid.FrameRate = 20;
newVid.Quality = 100;
open(newVid);

figure('color','w','position',[680, 500, 480, 480]);
hold on;
set(gca,'Visible','off')
xlim([-3, 3])
ylim([-3, 3])

Annotate(gca,'arrow', [-3, 3], [0, 0]);
Annotate(gca,'arrow', [0, 0], [-3, 3]);

for i = -3:2
    if i~=0
        line([i ,i], [-0.1, 0.1],'color','k')
        text(i, -0.3, num2str(i),'HorizontalAlignment','center');
    end
end

for i = -3:2
    if i~= 0
        line([-0.1, 0.1], [i ,i], 'color','k')
        text(-0.3, i, num2str(i),'HorizontalAlignment','center');
    end
end

% xlabel on original axis
text(2.9228, -0.3, '$$x$$','interpreter','latex','fontsize',12);
text(-0.3, 2.8105, '$$y$$','interpreter','latex','fontsize',12);

% �������� �׸���

h = Annotate(gca,'arrow', [0, 1], [0, 0]);
h.Primitive.Color = [1, 0, 0];
h.Primitive.LineWidth = 2;
text(0.35, -0.25,'$$\hat{i}$$','interpreter','latex','fontsize',12,'color','r','FontWeight','bold');

h = Annotate(gca,'arrow', [0, 0], [0, 1]);
h.Primitive.Color = [1, 0, 0];
h.Primitive.LineWidth = 2;
text(-0.25, 0.6,'$$\hat{j}$$','interpreter','latex','fontsize',12,'color','r','FontWeight','bold');

% line�� �׷��ֱ�
xx = linspace(-6, 6, 100);

spacing = [sin(linspace(0, pi/2, 50)), ones(1,25), sin(linspace(pi/2, 3*pi/2, 100)), ones(1,25)*(-1), sin(linspace(3*pi/2, 2*pi, 100))]+1.001;

for k = 1:length(spacing)
    sp = spacing(k);
    ii= 1;
    clear h
    for i = -3*sp:sp:4*sp
        h(ii) = plot(xx, -2 * xx + i,'k--');
        ii =ii +1;
    end
    
    xlim([-3, 3])
    ylim([-3, 3])
    t = text(-3, -3, ['scaling: ',sprintf('%.2f',1/sp)],'fontsize',15);
    
    if (2 / sp <3) && (1 / sp < 3)
        h_arrow = Annotate(gca, 'arrow', [0, 2/sp], [0, 1/ sp]);
        h_arrow.Primitive.Color = [1, 0, 0];
        h_arrow.Primitive.LineWidth = 2;
    else
        h_arrow = line([0, 2/sp],[0, 1/sp],'color','r','linewidth',2);
    end
    writeVideo(newVid, getframe(gcf))
    drawnow;
    
    if k < length(spacing)
        delete(h);
        delete(h_arrow);
        delete(t);
    end
end
close(newVid)

%% �� �຤���� ������ ��������� ���ο� �຤�ͷ� ���� ����� �ð�ȭ (1/3) (y ���������� �຤��)

figure('color','w','position',[680, 500, 480, 480]);
hold on;
set(gca,'Visible','off')
xlim([-3, 3])
ylim([-3, 3])

Annotate(gca,'arrow', [-3, 3], [0, 0]);
Annotate(gca,'arrow', [0, 0], [-3, 3]);

for i = -3:2
    if i~=0
        line([i ,i], [-0.1, 0.1],'color','k')
        text(i, -0.3, num2str(i),'HorizontalAlignment','center');
    end
end

for i = -3:2
    if i~= 0
        line([-0.1, 0.1], [i ,i], 'color','k')
        text(-0.3, i, num2str(i),'HorizontalAlignment','center');
    end
end

% xlabel on original axis
text(2.9228, -0.3, '$$x$$','interpreter','latex','fontsize',12);
text(-0.3, 2.8105, '$$y$$','interpreter','latex','fontsize',12);

% line�� �׷��ֱ�
xx = linspace(-6, 6, 100);

sp = spacing(k);
ii= 1;
clear h

for i = -3:3
    plot(xx, ones(1,length(xx)) * i,'k--');
end

xlim([-3, 3])
ylim([-3, 3])

h_arrow = Annotate(gca, 'arrow', [0, 0], [0, 1]);
h_arrow.Primitive.Color = [1, 0, 0];
h_arrow.Primitive.LineWidth = 2;


%% �� �຤���� ������ ��������� ���ο� �຤�ͷ� ���� ����� �ð�ȭ (2/3) (x ���������� �຤��)

figure('color','w','position',[680, 500, 480, 480]);
hold on;
set(gca,'Visible','off')
xlim([-3, 3])
ylim([-3, 3])

Annotate(gca,'arrow', [-3, 3], [0, 0]);
Annotate(gca,'arrow', [0, 0], [-3, 3]);

for i = -3:2
    if i~=0
        line([i ,i], [-0.1, 0.1],'color','k')
        text(i, -0.3, num2str(i),'HorizontalAlignment','center');
    end
end

for i = -3:2
    if i~= 0
        line([-0.1, 0.1], [i ,i], 'color','k')
        text(-0.3, i, num2str(i),'HorizontalAlignment','center');
    end
end

% xlabel on original axis
text(2.9228, -0.3, '$$x$$','interpreter','latex','fontsize',12);
text(-0.3, 2.8105, '$$y$$','interpreter','latex','fontsize',12);

% line�� �׷��ֱ�
xx = linspace(-6, 6, 100);

sp = spacing(k);
ii= 1;
clear h

for i = -3:3
    plot(ones(1,length(xx)) * i, xx, 'k--');
end

xlim([-3, 3])
ylim([-3, 3])

h_arrow = Annotate(gca, 'arrow', [0, 1], [0, 0]);
h_arrow.Primitive.Color = [1, 0, 0];
h_arrow.Primitive.LineWidth = 2;


%% �� �຤���� ������ ��������� ���ο� �຤�ͷ� ���� ����� �ð�ȭ (3/3) (45�� ������ �຤��)

figure('color','w','position',[680, 500, 480, 480]);
hold on;
set(gca,'Visible','off')
xlim([-3, 3])
ylim([-3, 3])

Annotate(gca,'arrow', [-3, 3], [0, 0]);
Annotate(gca,'arrow', [0, 0], [-3, 3]);

for i = -3:2
    if i~=0
        line([i ,i], [-0.1, 0.1],'color','k')
        text(i, -0.3, num2str(i),'HorizontalAlignment','center');
    end
end

for i = -3:2
    if i~= 0
        line([-0.1, 0.1], [i ,i], 'color','k')
        text(-0.3, i, num2str(i),'HorizontalAlignment','center');
    end
end

% xlabel on original axis
text(2.9228, -0.3, '$$x$$','interpreter','latex','fontsize',12);
text(-0.3, 2.8105, '$$y$$','interpreter','latex','fontsize',12);

% line�� �׷��ֱ�
xx = linspace(-6, 6, 100);

sp = spacing(k);
ii= 1;
clear h

for i = -10:10
    plot(xx, -xx + i/sqrt(2), 'k--');
end

xlim([-3, 3])
ylim([-3, 3])

h_arrow = Annotate(gca, 'arrow', [0, 1], [0, 1]);
h_arrow.Primitive.Color = [1, 0, 0];
h_arrow.Primitive.LineWidth = 2;

