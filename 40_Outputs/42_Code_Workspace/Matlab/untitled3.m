% ==========================================
% 空间扭曲的直观演示：网格的变形
% ==========================================

close all; clear; clc;

% 生成基础网格线的数据 (代表我们在平坦世界里的刻度尺)
num_lines = 21; % 网格线的数量
t = linspace(-1, 1, 100);
grid_points = linspace(-1, 1, num_lines);

figure('Name', '空间的演变：从平坦到扭曲', 'Position', [100, 200, 1200, 400]);

% === 第一步：平坦的欧几里得空间 (正常的方格纸) ===
subplot(1, 3, 1); hold on;
for i = 1:num_lines
    % 画水平线和垂直线
    plot(t, grid_points(i)*ones(size(t)), 'k-', 'Color', [0.6 0.6 0.6]);
    plot(grid_points(i)*ones(size(t)), t, 'k-', 'Color', [0.6 0.6 0.6]);
end
title('1. 欧几里得空间 (平坦网格)');
text(0, -1.2, '尺子的刻度处处均匀', 'HorizontalAlignment', 'center');
axis equal; axis([-1.1 1.1 -1.1 1.1]); axis off;

% === 第二步：正曲率空间 (类似球面，空间向外膨胀) ===
% 数学变换：让网格向中心收缩，边缘膨胀 (模拟将平铺的网格拉伸到球面上)
subplot(1, 3, 2); hold on;
for i = 1:num_lines
    % 水平线变形
    x_horiz = t;
    y_horiz = grid_points(i) * sqrt(1 - (t.^2)/2);
    plot(x_horiz, y_horiz, 'b-', 'LineWidth', 1);
    
    % 垂直线变形
    y_vert = t;
    x_vert = grid_points(i) * sqrt(1 - (t.^2)/2);
    plot(x_vert, y_vert, 'r-', 'LineWidth', 1);
end
title('2. 正曲率空间 (如封闭宇宙)');
text(0, -1.2, '空间在中央被挤压，边缘被拉伸', 'HorizontalAlignment', 'center');
axis equal; axis([-1.1 1.1 -1.1 1.1]); axis off;

% === 第三步：负曲率双曲空间 (庞加莱圆盘，贝特朗悖论的 1/3 解) ===
% 数学变换：将无限大的网格塞进一个有限的圆盘里
subplot(1, 3, 3); hold on;
% 画出宇宙的边界 (绝对的无穷远)
theta = linspace(0, 2*pi, 100);
plot(cos(theta), sin(theta), 'k-', 'LineWidth', 2);

for i = 1:num_lines
    % 基础直线
    line_x = t; 
    line_y = grid_points(i) * ones(size(t));
    
    % 庞加莱映射变换 (计算复杂的非欧变换)
    denom_horiz = 1 + line_x.^2 + line_y.^2;
    hx_horiz = (2 * line_x) ./ denom_horiz;
    hy_horiz = (2 * line_y) ./ denom_horiz;
    plot(hx_horiz, hy_horiz, 'b-', 'LineWidth', 1);
    
    % 垂直线变换
    denom_vert = 1 + line_y.^2 + line_x.^2;
    hx_vert = (2 * line_y) ./ denom_vert;
    hy_vert = (2 * line_x) ./ denom_vert;
    plot(hx_vert, hy_vert, 'r-', 'LineWidth', 1);
end
title('3. 双曲空间 (边缘即无穷)');
text(0, -1.2, '越靠近边缘，网格被极度压缩', 'HorizontalAlignment', 'center');
axis equal; axis([-1.1 1.1 -1.1 1.1]); axis off;