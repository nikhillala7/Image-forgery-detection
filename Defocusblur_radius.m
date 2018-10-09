clear
i = imread('sample22.jpg');
i = rgb2gray(i);
i = double(i);
%kernel = fspecial('disk', 5);
%i = imfilter(i,kernel);
[rows,columns] = size(i);
w = hann(rows);
m = zeros(rows,columns); 
w1 = hann(columns);
m = w*w1';
i = i.*m;

j = 1;
[rows,columns] = size(i);
count_row = 1;
count_col = 1;
check_row = 0;
rol = rows/3;
col = columns/3;

while count_row<rows && check_row==0
     k = 1;
    count_col =1;
    check_col =0;
     while count_col<columns && check_col==0
        
        if count_col+col>=columns && count_row+rol<rows
            block(j,k) =  mat2cell(i(count_row:count_row+rol,count_col:columns)); check_col =1;
        elseif count_row+rol>=rows && count_col+col<columns
            block(j,k) =  mat2cell(i(count_row:rows,count_col:count_col+col)); check_row=1;
        
        elseif count_col+col>=columns && count_row+rol>=rows
            block(j,k) =  mat2cell(i(count_row:rows,count_col:columns)); check_col =1;check_row=1;
        else
            block(j,k) = mat2cell(i(count_row:count_row+rol,count_col:count_col+col));
        end
        
        count_col = count_col + col;
        k = k+1;
        
     end
     count_row = count_row +rol;
     j=j+1;
end

for count = 1:j-1
    for count1 = 1:k-1
        [size_x,size_y] = size(cell2mat(block(count,count1)));
        b_radius(count,count1) = blur_radius(cell2mat(block(count,count1)),size_x,size_y);
    end
end