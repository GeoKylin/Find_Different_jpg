clear; close all; clc;

M = 60;

for N = 3:10
    file = [num2str(N),'.jpg'];
    im = imread(file);

    im1 = im(:,:,1);
    im1(im1>M) = 255;
    im1(im1<=M) = 0;

    top = find(sum(im1>0,2),1,'first');
    buttom = find(sum(im1>0,2),1,'last');
    left = find(sum(im1>0,1),1,'first');
    right = find(sum(im1>0,1),1,'last');

    im2 = im1(top:buttom,left:right);

    ry = length(find(~sum(im2>0,2)))/(2*(N-1));
    rx = length(find(~sum(im2>0,1)))/(2*(N-1));

    im2 = im1(round(top-ry):round(buttom+ry),...
        round(left-rx):round(right+rx));

    [y,x] = size(im2);
    dx = x/N;
    dy = y/N;

    matrix = zeros(N,N);
    for row = 1:N
        for colum = 1:N
            br = round((row - 1)*dy + 1);
            er = round(br + dy);
            er = min(er,y);

            bc = round((colum - 1)*dx + 1);
            ec = round(bc + dx);
            ec = min(ec,x);

            im3 = im2(br:er, bc:ec);
            matrix(row,colum) = sum(im3(:))/255;
        end
    end

    avr = mean(matrix(:));
    diff = abs(matrix - avr);
    [~,I] = max(diff(:));
    [row, colum] = ind2sub(size(diff),I);

    [y,x] = size(im1);

    br = round((row - 1)*dy + top - ry + 1);
    er = round(br + dy);
    er = min(er,y);

    bc = round((colum - 1)*dx + left - rx + 1);
    ec = round(bc + dx);
    ec = min(ec,x);

    im(br:er,bc,1) = 255; im(br:er,bc,2) = 0; im(br:er,bc,3) = 0; 
    im(br:er,ec,1) = 255; im(br:er,ec,2) = 0; im(br:er,ec,3) = 0; 
    im(br,bc:ec,1) = 255; im(br,bc:ec,2) = 0; im(br,bc:ec,3) = 0; 
    im(er,bc:ec,1) = 255; im(er,bc:ec,2) = 0; im(er,bc:ec,3) = 0;

    imwrite(im,['result_',num2str(N),'.jpg']);

    figure;
    imshow(im);
end
