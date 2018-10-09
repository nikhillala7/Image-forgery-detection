i = imread('image012.png');
i = i(:,:,1);
i = double(i);

[rows,columns] = size(i);
j = 1;

count_row = 1;
count_col = 1;
check_row = 0;
while count_row<rows && check_row==0
     k = 1;
    count_col =1;
    check_col =0;
     while count_col<columns && check_col==0
        
        if count_col+80>=columns && count_row+80<rows
            block(j,k) =  mat2cell(i(count_row:count_row+80,count_col:columns)); check_col =1;
        elseif count_row+80>=rows && count_col+80<columns
            block(j,k) =  mat2cell(i(count_row:rows,count_col:count_col+80)); check_row=1;
        
        elseif count_col+80>=columns && count_row+80>=rows
            block(j,k) =  mat2cell(i(count_row:rows,count_col:columns)); check_col =1;check_row=1;
        else
            block(j,k) = mat2cell(i(count_row:count_row+80,count_col:count_col+80));
        end
        
        count_col = count_col + 60;
        k = k+1;
        
     end
     count_row = count_row +60;
     j=j+1;
end

index = 1;
for count = 1:j-1
    for count1 = 1:k-1
        subplot(j-1,k-1,index)
        imshow(cell2mat(block(count,count1)),[])
        index = index+1;
    end
end

for count = 1:j-1
    for count1 = 1:k-1
        b_dir(count,count1) = blur_angle(cell2mat(block(count,count1)));
        b_mag(count,count1) = EstLen(cell2mat(block(count,count1)),b_dir(count,count1),0);
    end
end

        
 