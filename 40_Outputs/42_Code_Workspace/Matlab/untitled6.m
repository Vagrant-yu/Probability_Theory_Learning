% ==========================================
% 相对论空间扭曲动态演示：速度与质量的效应
% ==========================================

close all; clear; clc;
figure('Name', '宇宙的弹性：速度与质量引发的空间扭曲', 'Position', [100, 150, 1200, 550], 'Color', 'w');

% === 准备左侧数据 (速度引发的尺缩效应) ===
subplot(1, 2, 1);
hold on; axis equal; axis([-2 2 -2 2]); grid on;
title('狭义相对论：低速到接近光速 (X方向尺缩)', 'FontSize', 14);
% 画一个原本完美的圆形（代表静止时的物体或空间域）
theta = linspace(0, 2*pi, 100);
circle_x = cos(theta); circle_y = sin(theta);
h_circle = fill(circle_x, circle_y, 'b', 'FaceAlpha', 0.5, 'EdgeColor', 'b', 'LineWidth', 2);
h_text_v = text(-1.8, 1.8, '速度 v = 0 c', 'FontSize', 12, 'FontWeight', 'bold');

% === 准备右侧数据 (质量引发的引力势阱) ===
subplot(1, 2, 2);
[X, Y] = meshgrid(linspace(-3, 3, 50));
R = sqrt(X.^2 + Y.^2);
Z_flat = zeros(size(X));
h_surf = surf(X, Y, Z_flat, 'FaceColor', 'cyan', 'EdgeColor', [0.3 0.3 0.3], 'FaceAlpha', 0.8);
axis([-3 3 -3 3 -5 1]); view(35, 30); grid on;
title('广义相对论：小质量到大质量 (引力井/漏斗)', 'FontSize', 14);
zlabel('空间曲率 (Z)');
camlight('headlight'); lighting gouraud;
h_text_m = text(0, 0, 2, '中心质量 M = 0', 'FontSize', 12, 'FontWeight', 'bold');

pause(2); % 停留2秒，观察静止和平坦状态

% === 开始双动画演化 ===
frames = 100;
for i = 1:frames
    t = i / frames; % t 从 0 增加到 1
    
    % ---------------------------------------------------
    % 1. 左侧动画计算：速度 v 从 0 加速到 0.95c (光速)
    % ---------------------------------------------------
    v = 0.95 * t; 
    gamma = 1 / sqrt(1 - v^2); % 洛伦兹因子 (设 c=1)
    
    % X方向发生尺缩效应 (长度收缩为原来的 1/gamma)
    new_x = circle_x / gamma; 
    set(h_circle, 'XData', new_x);
    set(h_text_v, 'String', sprintf('速度 v = %.2f c', v));
    
    % ---------------------------------------------------
    % 2. 右侧动画计算：质量 M 从 0 增加到 黑洞级别
    % ---------------------------------------------------
    M = 4 * t; % 质量逐渐变大
    % 模拟弗拉姆抛物面 (Flamm's paraboloid)，即广义相对论中的引力井
    Z_gravity = -M ./ (R.^2 * 0.5 + 0.5); 
    set(h_surf, 'ZData', Z_gravity);
    set(h_text_m, 'String', sprintf('中心质量 M = %.1f', M));
    
    drawnow;
    pause(0.05);
end