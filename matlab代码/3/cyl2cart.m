%% 函数：将柱坐标系下的矢量场转换到直角坐标系
function [X, Y, Z, Vx, Vy, Vz] = cyl2cart(R, Theta, Z_cyl, Vr, Vtheta, Vz_cyl)
    % 柱坐标系到直角坐标系的完整转换
    % 输入：
    %   R, Theta, Z_cyl: 柱坐标网格
    %   Vr, Vtheta, Vz_cyl: 柱坐标系下的矢量分量
    % 输出：
    %   X, Y, Z: 直角坐标网格
    %   Vx, Vy, Vz: 直角坐标系下的矢量分量
    
    % 坐标转换
    X = R .* cos(Theta);
    Y = R .* sin(Theta);
    Z = Z_cyl;  % z坐标不变
    
    % 矢量分量转换
    Vx = Vr .* cos(Theta) - Vtheta .* sin(Theta);
    Vy = Vr .* sin(Theta) + Vtheta .* cos(Theta);
    Vz = Vz_cyl;  % z分量不变
    
    % 验证输出
    if nargout > 0
        fprintf('柱->直角坐标转换完成\n');
        fprintf('  输入网格尺寸: %dx%dx%d\n', size(R));
        fprintf('  输出网格尺寸: %dx%dx%d\n', size(X));
        fprintf('  X范围: [%.2f, %.2f]\n', min(X(:)), max(X(:)));
        fprintf('  Y范围: [%.2f, %.2f]\n', min(Y(:)), max(Y(:)));
    end
end