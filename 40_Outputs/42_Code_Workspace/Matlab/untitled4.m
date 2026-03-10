% ==========================================
% 3D 空间扭曲动态演示：从平坦到非欧空间的连续变换
% ==========================================

close all; clear; clc;
disp('正在启动 3D 空间扭曲引擎...');

% 1. 构建初始的平坦宇宙“网格” (X 和 Y 代表我们的二维坐标)
[X, Y] = meshgrid(linspace(-3, 3, 45));
figure('Name', '3D 空间变换动态演示', 'Position', [200, 200, 900, 700]);

% 初始 Z 坐标全为 0，代表完全平坦的欧几里得空间
Z = zeros(size(X));

% 绘制 3D 曲面 (保留黑色网格线，以便观察空间的“拉伸”)
s = surf(X, Y, Z, 'EdgeColor', [0.2 0.2 0.2], 'FaceColor', 'cyan', 'FaceAlpha', 0.7);
axis([-3 3 -3 3 -5 1]); % 固定坐标轴范围，防止动画跳动
view(40, 35);           % 设定一个完美的上帝视角
grid on;
xlabel('X 空间坐标'); ylabel('Y 空间坐标'); zlabel('Z (空间扭曲深度)');

% 添加光照，让 3D 材质更有立体感
camlight('headlight'); 
lighting gouraud;
material shiny;

title('初始状态：平坦的欧几里得空间 (网格均匀，随处相同)', 'FontSize', 14);
pause(2); % 停顿 2 秒，让你先看清平坦的样子

% 2. 开始动画：模拟空间规则(度规)的改变或巨大质量的引入
frames = 80; % 动画帧数
for i = 1:frames
    % t 是时间演化参数，从 0 慢慢走向 1
    t = i / frames; 
    
    % 数学魔法：利用高斯函数动态构建漏斗形的非欧空间
    % 随着 t 的增加，深度 (depth) 变大，影响范围 (width) 收窄
    depth = 4.5 * t;          
    width = 3 - 2 * t;        
    
    % 计算新的 Z 坐标 (网格向下拉伸)
    Z_new = -depth * exp(-(X.^2 + Y.^2) / width);
    
    % 更新图像数据
    set(s, 'ZData', Z_new);
    
    % 动态更新标题，解释正在发生什么
    if t < 0.3
        title('变换开始：空间规则发生改变，中心开始轻微下陷...', 'FontSize', 14, 'Color', 'b');
    elseif t < 0.7
        title('扭曲加剧：注意看中心区域的黑色网格线，它们被严重拉伸了！', 'FontSize', 14, 'Color', [0.8 0.4 0]);
    else
        title('彻底变为非欧空间：形成了贝特朗悖论中的“漏斗形”宇宙', 'FontSize', 14, 'Color', 'r');
    end
    
    drawnow;       % 强制 MATLAB 立即渲染当前帧
    pause(0.04);   % 控制动画播放速度
end

disp('变换完成！你可以用鼠标拖动图像，从不同角度观察这个扭曲的空间。');