batch = zeros(size(img,1)*size(img,2),3,'double');
for i=1:size(img,2) 
    for j=1:size(img,1) 
        tmp = double(img(j,i,:));
        batch(size(img,1)*(i-1)+j,:) = tmp(:)';
    end;
end;
batch = sim(netRGB2HSV,batch')';
batch = reshape(batch, [size(img,1), size(img,2), 3]);

H=(batch(:,:,1));
S=(batch(:,:,2));
V=(batch(:,:,3));
subplot(2,3,1), imshow(H)
subplot(2,3,2), imshow(S)
subplot(2,3,3), imshow(V)
suptitle('Resulting image using neural network');


HSV=rgb2hsv(img);

H=HSV(:,:,1);
S=HSV(:,:,2);
V=HSV(:,:,3);
subplot(2,3,4), imshow(H)
subplot(2,3,5), imshow(S)
subplot(2,3,6), imshow(V)
suptitle('RGB2HSV conversion: 1^{st} row - NN, 2^{nd} row - MATLAB function');