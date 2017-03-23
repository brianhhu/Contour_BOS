function input = add_mihalas_attention(input,Pop,w_att,Xatt,Yatt,sdatt,condition)


if nargin<4
    Xatt = 24;
    Yatt = 24;
    sdatt = 8;
end
if nargin<3
    w_att = 0.07;
end

if strcmp(condition,'figure')
    % BOS Network
    r_list = [Pop(5).subpops(:).val];
    r0 = 2;

    input(5).sparseness = ones(size(input(5).sparseness)); %add input to Go cells

    for ss = 1:length(input(5).sparseness);
        scale = r_list(ss)/r0*2;
        sd = sdatt/scale;
        xatt = Xatt/scale;yatt = Yatt/scale;
        dim = Pop(5).subpops(ss).dim;
        input(5).subpop_conn(ss).weight = w_att;
        input(5).subpop_conn(ss).matrix = zeros(dim);
        [x, y] = meshgrid(1:dim(2),1:dim(1)); %NOTE: here Y increases going down, unlike conventions elsewhere
        input(5).subpop_conn(ss).matrix = exp(-((x-xatt).^2+(y-yatt).^2)/(2*sd^2));
    end
end

if strcmp(condition,'contour')
    % Contour Grouping Network
    r_list = 8*ones(1,4);
    r0 = 2;
 
    input(7).sparseness = ones(size(input(7).sparseness)); %add input to Gc cells
 
    for ss = 1:length(input(7).sparseness);
        scale = r_list(ss)/r0*2;
        sd = sdatt/scale;
        xatt = Xatt/scale;yatt = Yatt/scale;
        dim = Pop(7).subpops(ss).dim;
        input(7).subpop_conn(ss).weight = w_att;
        input(7).subpop_conn(ss).matrix = zeros(dim);
        [x, y] = meshgrid(1:dim(2),1:dim(1)); %NOTE: here Y increases going down, unlike conventions elsewhere
        input(7).subpop_conn(ss).matrix = exp(-((x-xatt).^2+(y-yatt).^2)/(2*sd^2));
    end
end
