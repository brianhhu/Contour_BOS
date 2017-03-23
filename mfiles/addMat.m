function M=addMat(M,x,y,N)
% adds the matrix N (needs to have odd size) to M with the center of N at x,y in M

[imax,jmax]=size(N);

M(y-floor(imax/2):y+floor(imax/2),x-floor(jmax/2):x+floor(jmax/2)) = N;