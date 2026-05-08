%% 函数：将球坐标系下的矢量场转换到柱坐标系
function [R_cyl, Theta_cyl, Z, Vr_cyl, Vtheta_cyl, Vz] = sph2cyl(R_sph, Theta, Phi, Vr_sph, Vtheta_sph, Vphi_sph)
    % 球坐标系到柱坐标系的完整转换
    % 输入：
    %   R_sph, Theta, Phi: 球坐标
    %   Vr_sph, Vtheta_sph, Vphi_sph: 球坐标系下的矢量分量
    % 输出：
    %   R_cyl, Theta_cyl, Z: 柱坐标
    %   Vr_cyl, Vtheta_cyl, Vz: 柱坐标系下的矢量分量
    
    % 计算柱坐标
    R_cyl = R_sph .* sin(Theta);
    Theta_cyl = Phi;  % 方位角相同
    Z = R_sph .* cos(Theta);
    
    % 处理Theta_cyl范围 [0, 2π]
    Theta_cyl = mod(Theta_cyl, 2*pi);
    
    % 避免奇点
    sin_Theta = sin(Theta);
    sin_Theta(sin_Theta == 0) = eps;
    
    % 矢量分量转换
    Vr_cyl = Vr_sph .* sin(Theta) + Vtheta_sph .* cos(Theta);
    Vtheta_cyl = Vphi_sph;  % 方位角分量不变
    Vz = Vr_sph .* cos(Theta) - Vtheta_sph .* sin(Theta);
    
    % 处理z轴奇点
    zaxis_idx = (sin_Theta == 0);
    if any(zaxis_idx(:))
        Vr_cyl(zaxis_idx) = 0;
        Vtheta_cyl(zaxis_idx) = 0;
        Vz(zaxis_idx) = Vr_sph(zaxis_idx) .* sign(cos(Theta(zaxis_idx)));
    end
    
    % 验证输出
    if nargout > 0
        fprintf('球->柱坐标转换完成\n');
        fprintf('  R_cyl范围: [%.2f, %.2f]\n', min(R_cyl(:)), max(R_cyl(:)));
        fprintf('  Z范围: [%.2f, %.2f]\n', min(Z(:)), max(Z(:)));
    end
end