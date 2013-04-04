% Set up 3D test image
% load the 3D image of size 100
V = tom_emread();
value = V.Value;

% parameters
[v_length, v_width,v_height] = size(value);

theta = 0:5:179;
R = zeros(size(value,1), size(value,1),length(theta));

% take 36 projections
for i = 1:length(theta)
    %rotate matrix
    rotated_img = tom_rotate(value, [270,90,-theta(i)], 'linear');
    R(:,:,i) = sum(rotated_img);
end

% allocate the memory 
X = zeros(v_length, v_width,v_height); 
[A] = SystemMatrix(v_width,theta);

% reconstruct
[Xx] = ART3(A,R,0.25,2); % ART3
%[Xx] = SIRT3(A,R,50);   % SIRT3
tom_volxyz(Xx);




