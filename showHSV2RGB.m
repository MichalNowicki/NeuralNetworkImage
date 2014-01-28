imgHSV = rgb2hsv(img);

batch = zeros(size(img,1)*size(img,2) ,3,'single');
for i=1:size(img,2) 
    for j=1:size(img,1) 
        tmp = double(imgHSV(j,i,:));
        batch(size(imgHSV,1)*(i-1)+j,:) = tmp(:)';
    end;
end;
batch = sim(netHSV2RGB,batch')';
batch = reshape(batch, [size(imgHSV,1), size(imgHSV,2), 3]);

R=(batch(:,:,1));
G=(batch(:,:,2));
B=(batch(:,:,3));
figure;
subplot(2,3,1), imshow(R)
subplot(2,3,2), imshow(G)
subplot(2,3,3), imshow(B)

RGB=hsv2rgb(imgHSV);
R=RGB(:,:,1);
G=RGB(:,:,2);
B=RGB(:,:,3);
subplot(2,3,4), imshow(R)
subplot(2,3,5), imshow(G)
subplot(2,3,6), imshow(B)
suptitle('HSV2RGB conversion: 1^{st} row - NN, 2^{nd} row - MATLAB function');