%% 函数：将柱坐标系下的矢量场转换到球坐标系
function [R_sph, Theta, Phi, Vr_sph, Vtheta, Vphi] = cyl2sph(R_cyl, Theta_cyl, Z, Vr_cyl, Vtheta_cyl, Vz)
    % 柱坐标系到球坐标系的完整转换
    % 输入：
    %   R_cyl, Theta_cyl, Z: 柱坐标
    %   Vr_cyl, Vtheta_cyl, Vz: 柱坐标系下的矢量分量
    % 输出：
    %   R_sph, Theta, Phi: 球坐标
    %   Vr_sph, Vtheta, Vphi: 球坐标系下的矢量分量
    
    % 计算球坐标
    R_sph = sqrt(R_cyl.^2 + Z.^2);
    Theta = atan2(R_cyl, Z);  % 极角，[0, π]
    Phi = Theta_cyl;          % 方位角，[0, 2π]
    
    % 处理Theta范围
    Theta(Theta < 0) = Theta(Theta < 0) + pi;
    
    % 避免奇点
    R_sph_safe = R_sph;
    R_sph_safe(R_sph_safe == 0) = eps;
    
    % 计算sin和cos
    sin_alpha = R_cyl ./ (R_sph_safe);
    cos_alpha = Z ./ (R_sph_safe);
    
    % 矢量分量转换
    Vr_sph = Vr_cyl .* sin_alpha + Vz .* cos_alpha;
    Vtheta = Vr_cyl .* cos_alpha - Vz .* sin_alpha;
    Vphi = Vtheta_cyl;  % 方位角分量不变
    
    % 处理原点奇点
    origin_idx = (R_sph == 0);
    if any(origin_idx(:))
        Vr_sph(origin_idx) = 0;
        Vtheta(origin_idx) = 0;
        Vphi(origin_idx) = 0;
    end
    
    % 验证输出
    if nargout > 0
        fprintf('柱->球坐标转换完成\n');
        fprintf('  R_sph范围: [%.2f, %.2f]\n', min(R_sph(:)), max(R_sph(:)));
        fprintf('  θ范围: [%.2f, %.2f] rad\n', min(Theta(:)), max(Theta(:)));
    end
end
