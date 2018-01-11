function [] = printMatrix(A, d)
% Prints a matrix (or vector) in latex format
% USAGAE: [] = printMatrix(A)
[m, n] = size(A);
% create a string that contains n floats
if (~exist('d', 'var'))
  d = false;
end
if ~d
  format = cell(1,n);
  format(:) = {'%.2f & '};
  format(end) = {'%.2f \\\\ \n'};
  s = '';
  for i = 1:n
    s = strcat(s, format{i});
  end
  for i = 1:m
    if (i == m)
      
      format(end) = {'%.2f  \n'};
      s = '';
      for j = 1:n
        s = strcat(s, format{j});
      end
    end
    fprintf(s, A(i,:))
    
  end
else
   format = cell(1,n);
  format(:) = {'%d & '};
  format(end) = {'%d \\\\ \n'};
  s = '';
  for i = 1:n
    s = strcat(s, format{i});
  end
  for i = 1:m
    if (i == m)
      
      format(end) = {'%d  \n'};
      s = '';
      for j = 1:n
        s = strcat(s, format{j});
      end
    end
    fprintf(s, A(i,:))
    
  end
end