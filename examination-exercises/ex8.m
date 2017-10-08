% exercise 8
% Observe that this is not the full sample correlation matrix, i.e., just
% the upper half. Before analyzing make the matrix symmetric.

R = [1.00  0.78  0.70  0.91  0.91  0.95  0.63  0.92  0.75  0.92  0.90  0.78  0.86  0.90  0.55  0.63  0.77  0.67  0.83  0.59  0.41;
  0 1.00  0.51  0.84  0.77  0.84  0.66  0.75  0.59  0.72  0.79  0.65  0.61  0.64  0.43  0.45  0.59  0.55  0.67  0.57  0.41;
  0 0 1.00  0.62  0.64  0.64  0.46  0.77  0.46  0.64  0.64 0.52  0.56  0.59  0.25  0.60  0.68  0.62  0.80  0.60  0.39;
  0 0 0 1.00  0.93  0.94  0.66  0.89  0.66  0.91  0.90 0.68  0.72  0.78  0.51  0.60  0.68  0.62  0.80  0.60  0.39;
  0 0 0 0 1.00  0.94  0.64  0.88  0.74  0.91  0.89 0.66  0.73  0.80  0.52  0.53  0.68  0.65  0.80  0.55  0.41;
  0 0 0 0 0 1.00  0.63  0.96  0.77  0.90  0.90 0.75  0.77  0.84  0.64  0.56  0.80  0.69  0.80  0.58  0.40;
  0 0 0 0 0 0 1.00  0.48  0.61  0.55  0.56 0.41  0.50  0.57  0.49  0.60  0.60  0.37  0.47  0.46  0.46;
  0 0 0 0 0 0 0 1.00  0.94  0.95  0.89 0.69  0.71  0.78  0.33  0.50  0.53  0.60  0.81  0.59  0.37;
  0 0 0 0 0 0 0 0 1.00  0.70  0.84 0.51  0.53  0.58  0.53  0.38  0.57  0.72  0.69  0.55  0.56;
  0 0 0 0 0 0 0 0 0 1.00  0.93 0.71  0.82  0.83  0.61  0.50  0.64  0.71  0.80  0.62  0.36;
  0 0 0 0 0 0 0 0 0 0 1.00 0.52  0.79  0.83  0.73  0.69  0.73  0.65  0.75  0.71  0.37;
  0 0 0 0 0 0 0 0 0 0 0 1.00  0.68  0.73  0.41  0.50  0.57  0.57  0.68  0.41  0.33;
  0 0 0 0 0 0 0 0 0 0 0 0 1.00  0.89  0.40  0.55  0.66  0.67  0.79  0.54  0.41;
  0 0 0 0 0 0 0 0 0 0 0 0 0 1.00  0.44  0.67  0.70  0.65  0.82  0.53  0.44;
  0 0 0 0 0 0 0 0 0 0 0 0 0 0 1.00  0.39  0.51  0.42  0.68  0.41  0.33;
  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1.00  0.63  0.45  0.59  0.39  0.38;
  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1.00  0.52  0.60  0.55  0.55;
  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1.00  0.75  0.43  0.33;
  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1.00  0.50  0.37;
  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1.00  0.27;
  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1.00];
p = length(R);
R = R + R' - eye(p);

disp('(a)')
[V, D] = eig(R);
coverage = diag(D);
coverage = coverage/ (sum(coverage(coverage > 0)));
coverage(coverage < 0) = 0;

mainComponents = find(cumsum(coverage, 'reverse')<0.87)
% note that we 87 % to cover the main compoents that covers at least 85 %


mainComponentsVectors = V(:,mainComponents)

[(1:21)', mainCompentsVectors(:,end)]

% the first PCA detmines what messures are the most important fro male
% sperm whales


% the second PC we see that the last messure is greatly over represented
% compared to the other messurements. This means that we can find alot of
% variance in the legnth of the base of dorsal thin.


  