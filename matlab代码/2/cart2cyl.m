%% 函数：将直角坐标系下的矢量场转换到柱坐标系
function [R, Theta, Z, Vr, Vtheta, Vz] = cart2cyl(X, Y, Z, Vx, Vy, Vz)
    % 直角坐标系到柱坐标系的完整转换（包含坐标和矢量）
    % 输入：
    %   X, Y, Z: 直角坐标网格
    %   Vx, Vy, Vz: 直角坐标系下的矢量分量
    % 输出：
    %   R, Theta, Z: 柱坐标网格
    %   Vr, Vtheta, Vz: 柱坐标系下的矢量分量
    
    % 计算柱坐标
    R = sqrt(X.^2 + Y.^2);
    Theta = atan2(Y, X);
    
    % 处理Theta范围 [-π, π] → [0, 2π]
    Theta(Theta < 0) = Theta(Theta < 0) + 2*pi;
    
    % 避免r=0处的奇点
    R_safe = R;
    R_safe(R_safe == 0) = eps;
    
    % 矢量分量转换
    Vr = Vx .* cos(Theta) + Vy .* sin(Theta);
    Vtheta = -Vx .* sin(Theta) + Vy .* cos(Theta);
    Vz_cyl = Vz;  % z分量不变
    
    % 处理奇点：在r=0处
    zero_idx = (R == 0);
    if any(zero_idx(:))
        Vr(zero_idx) = 0;  % 在原点，径向分量为0
        Vtheta(zero_idx) = 0;  % 角向分量在原点未定义，设为0
    end
    
    % 重命名输出
    Vz = Vz_cyl;
    
    % 验证输出网格
    if nargout > 0
        fprintf('直角->柱坐标转换完成\n');
        fprintf('  输入网格尺寸: %dx%dx%d\n', size(X));
        fprintf('  输出网格尺寸: %dx%dx%d\n', size(R));
        fprintf('  R范围: [%.2f, %.2f]\n', min(R(:)), max(R(:)));
        fprintf('  θ范围: [%.2f, %.2f] rad\n', min(Theta(:)), max(Theta(:)));
    end
end