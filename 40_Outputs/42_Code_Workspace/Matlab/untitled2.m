% ==========================================
% 贝特朗悖论的三种空间几何可视化
% ==========================================

close all; clear; clc;

% === 图1：平坦欧几里得空间 (对应解法1：距离 r 均匀) ===
% 这是我们日常感知的世界，距离度规是均匀的
figure('Name', '欧几里得空间', 'Position', [100, 200, 400, 400]);
hold on;
theta = linspace(0, 2*pi, 100);
% 绘制边界
plot(cos(theta), sin(theta), 'k-', 'LineWidth', 2);
% 绘制等距同心圆 (物理距离 r = 0.2, 0.4, 0.6...)
for r = 0.2:0.2:0.8
    plot(r*cos(theta), r*sin(theta), 'b-', 'LineWidth', 1.5);
end
% 绘制过圆心的直线
for alpha = 0:pi/6:pi-pi/6
    plot([-1 1]*cos(alpha), [-1 1]*sin(alpha), 'r-', 'LineWidth', 1);
end
title('1. 欧几里得空间 (距离 r 均匀)');
text(0, -1.2, '同心圆间距均匀，空间是平坦且线性的', 'HorizontalAlignment', 'center');
axis equal; axis([-1.3 1.3 -1.3 1.3]); axis off;
hold off;


% === 图2：双曲空间/庞加莱圆盘 (对应解法2：端点角度均匀) ===
% 空间在边缘处被极度压缩，边缘即是无穷远
figure('Name', '双曲空间', 'Position', [550, 200, 400, 400]);
hold on;
% 绘制边界 (在双曲几何中，这是永远无法到达的无穷远)
plot(cos(theta), sin(theta), 'k-', 'LineWidth', 2);
% 绘制双曲空间中“物理距离相等”的同心圆
% 根据度规，双曲距离 d = ln((1+r)/(1-r))，故对应的欧氏半径 r = tanh(d/2)
for d = 0.5:0.5:3.5
    r = tanh(d/2);
    plot(r*cos(theta), r*sin(theta), 'b-', 'LineWidth', 1.5);
end
% 绘制过原点的测地线
for alpha = 0:pi/6:pi-pi/6
    plot([-1 1]*cos(alpha), [-1 1]*sin(alpha), 'r-', 'LineWidth', 1);
end
title('2. 庞加莱圆盘模型 (端点均匀分布)');
text(0, -1.2, '物理距离相等的圆在边缘被无限压缩，边缘即无穷广阔', 'HorizontalAlignment', 'center');
axis equal; axis([-1.3 1.3 -1.3 1.3]); axis off;
hold off;


% === 图3：伪球体/漏斗形空间 (对应解法3：面积中点均匀) ===
% 越远离中心，空间的“横截面积”扩张越剧烈
figure('Name', '漏斗形空间', 'Position', [1000, 200, 500, 450]);
u = linspace(0, 2*pi, 60);
v = linspace(0.05, pi/2, 60); % 避免在 v=0 处出现奇点
[U, V] = meshgrid(u, v);

% 伪球体 (Pseudosphere) 的参数方程
X = cos(U) .* sin(V);
Y = sin(U) .* sin(V);
Z = cos(V) + log(tan(V/2));

surf(X, Y, Z);
shading interp;         % 平滑着色
colormap(parula);       % 设置渐变色
light; lighting gouraud;% 添加光照显得更有立体感

title({'3. 伪球体/漏斗空间 (面积中点均匀)', '越往上(远离原点)，空间面积呈爆炸性增长'});
zlabel('空间纵深');
view(30, 20);           % 调整观察视角
axis equal; axis off;