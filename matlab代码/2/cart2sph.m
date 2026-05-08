%% 函数：将直角坐标系下的矢量场转换到球坐标系
function [R, Theta, Phi, Vr, Vtheta, Vphi] = cart2sph(X, Y, Z, Vx, Vy, Vz)
    % 直角坐标系到球坐标系的完整转换
    % 注意：Theta是极角（与z轴的夹角），Phi是方位角
    % 输入：
    %   X, Y, Z: 直角坐标网格
    %   Vx, Vy, Vz: 直角坐标系下的矢量分量
    % 输出：
    %   R, Theta, Phi: 球坐标网格
    %   Vr, Vtheta, Vphi: 球坐标系下的矢量分量
    
    % 计算球坐标
    R = sqrt(X.^2 + Y.^2 + Z.^2);
    Theta = acos(Z ./ (R + eps));  % 极角，[0, π]
    Phi = atan2(Y, X);             % 方位角，[-π, π]
    
    % 处理Phi范围 [-π, π] → [0, 2π]
    Phi(Phi < 0) = Phi(Phi < 0) + 2*pi;
    
    % 避免奇点
    R_safe = R;
    R_safe(R_safe == 0) = eps;
    
    sin_Theta = sin(Theta);
    sin_Theta(sin_Theta == 0) = eps;
    
    % 矢量分量转换
    Vr = Vx .* sin_Theta .* cos(Phi) + ...
         Vy .* sin_Theta .* sin(Phi) + ...
         Vz .* cos(Theta);
    
    Vtheta = Vx .* cos(Theta) .* cos(Phi) + ...
             Vy .* cos(Theta) .* sin(Phi) - ...
             Vz .* sin_Theta;
    
    Vphi = -Vx .* sin(Phi) + ...
            Vy .* cos(Phi);
    
    % 处理原点奇点
    origin_idx = (R == 0);
    if any(origin_idx(:))
        Vr(origin_idx) = 0;
        Vtheta(origin_idx) = 0;
        Vphi(origin_idx) = 0;
    end
    
    % 验证输出
    if nargout > 0
        fprintf('直角->球坐标转换完成\n');
        fprintf('  输入网格尺寸: %dx%dx%d\n', size(X));
        fprintf('  输出网格尺寸: %dx%dx%d\n', size(R));
        fprintf('  R范围: [%.2f, %.2f]\n', min(R(:)), max(R(:)));
        fprintf('  θ范围: [%.2f, %.2f] rad\n', min(Theta(:)), max(Theta(:)));
        fprintf('  φ范围: [%.2f, %.2f] rad\n', min(Phi(:)), max(Phi(:)));
    end
end