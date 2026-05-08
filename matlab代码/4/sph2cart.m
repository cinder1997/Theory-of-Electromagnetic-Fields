%% 函数：将球坐标系下的矢量场转换到直角坐标系
function [X, Y, Z, Vx, Vy, Vz] = sph2cart(R, Theta, Phi, Vr, Vtheta, Vphi)
    % 球坐标系到直角坐标系的完整转换
    % 输入：
    %   R, Theta, Phi: 球坐标网格
    %   Vr, Vtheta, Vphi: 球坐标系下的矢量分量
    % 输出：
    %   X, Y, Z: 直角坐标网格
    %   Vx, Vy, Vz: 直角坐标系下的矢量分量
    
    % 坐标转换
    X = R .* sin(Theta) .* cos(Phi);
    Y = R .* sin(Theta) .* sin(Phi);
    Z = R .* cos(Theta);
    
    % 避免奇点
    sin_Theta = sin(Theta);
    sin_Theta(sin_Theta == 0) = eps;
    
    % 矢量分量转换
    Vx = Vr .* sin_Theta .* cos(Phi) + ...
         Vtheta .* cos(Theta) .* cos(Phi) - ...
         Vphi .* sin(Phi);
    
    Vy = Vr .* sin_Theta .* sin(Phi) + ...
         Vtheta .* cos(Theta) .* sin(Phi) + ...
         Vphi .* cos(Phi);
    
    Vz = Vr .* cos(Theta) - ...
         Vtheta .* sin_Theta;
    
    % 处理z轴奇点
    zaxis_idx = (sin_Theta == 0);
    if any(zaxis_idx(:))
        Vx(zaxis_idx) = 0;
        Vy(zaxis_idx) = 0;
        Vz(zaxis_idx) = Vr(zaxis_idx) .* sign(cos(Theta(zaxis_idx)));
    end
    
    % % 验证输出
    % if nargout > 0
    %     fprintf('球->直角坐标转换完成\n');
    %     fprintf('  输入网格尺寸: %dx%dx%d\n', size(R));
    %     fprintf('  输出网格尺寸: %dx%dx%d\n', size(X));
    %     fprintf('  X范围: [%.2f, %.2f]\n', min(X(:)), max(X(:)));
    %     fprintf('  Y范围: [%.2f, %.2f]\n', min(Y(:)), max(Y(:)));
    % end
end