V = tom_emread();
value = V.Value;

% parameters
[v_length, v_width,v_height] = size(value);

theta = 0:5:179;
R = zeros(length(theta), size(value,1), size(value,1));

% take 60 projections
for i = 1:length(theta)
    %rotate matrix
    rotated_img = tom_rotate(value, [270, 90, -theta(i)], 'linear');
    R(i,:,:) = sum(rotated_img);
end

% reconstrct
fftImage = fftreconst3d(R,theta);

%result
tom_volxyz(fftImage);


