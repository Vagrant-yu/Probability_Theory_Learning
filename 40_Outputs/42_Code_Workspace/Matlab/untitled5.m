% ==========================================
% 3D 动态演示：从平坦平面到双曲空间的演化
% ==========================================

close all; clear; clc;

% 创建基础坐标网格
[X, Y] = meshgrid(linspace(-3, 3, 30));

figure('Name', '双曲空间 (Hyperboloid Model) 动态演化', 'Position', [150, 150, 900, 700]);

% 初始状态：完全平坦的 Z = 0 欧氏平面
Z_flat = zeros(size(X));
h = surf(X, Y, Z_flat, 'FaceColor', 'interp', 'EdgeColor', [0.3 0.3 0.3], 'FaceAlpha', 0.8);
colormap(cool);
axis([-3 3 -3 3 0 4]); % Z轴预留向上的空间
view(35, 25);
grid on;
xlabel('X 轴'); ylabel('Y 轴'); zlabel('曲率几何维度');
title('初始状态：平坦欧几里得空间 (网格均匀直交)', 'FontSize', 13);

% 添加光源感
camlight('right');
lighting gouraud;

pause(2); % 停留 2 秒观察平坦状态

% 动画：引入负曲率，空间开始向上翘曲形成双曲面
frames = 100;
for i = 1:frames
    t = i / frames; % t 从 0 到 1
    
    % 双曲面公式：Z^2 - X^2 - Y^2 = 1 (当曲率为完全体时)
    % 我们让 Z 从 0 平滑过渡到 sqrt(1 + X^2 + Y^2) - 1
    Z_hyperbolic = sqrt(1 + X.^2 + Y.^2) - 1; 
    
    % 当前帧的 Z 坐标是平坦和双曲的线性插值
    Z_current = t * Z_hyperbolic;
    
    set(h, 'ZData', Z_current);
    
    if t < 0.5
        title('空间开始发生“负曲率”扭曲...', 'FontSize', 13, 'Color', 'b');
    else
        title({'最终形态：双曲面模型 (Hyperbolic Space)', '边缘无限向上延伸，网格实际物理面积在剧增！'}, 'FontSize', 13, 'Color', 'r');
    end
    
    drawnow;
    pause(0.03);
end