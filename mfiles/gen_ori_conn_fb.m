function conn = gen_ori_conn_fb(from_pop,to_pop,func,x,y,sd)
% conn = gen_ori_conn_fb(from_pop,to_pop,func,x,y)
% Creates a connection structure between two orientation populations. 
% Connection runs from from_pop to to_pop and is defined in terms of the
% output of the function handle func. x and y are outputs of the meshgrid
% function that are used to determine the coordinate system in func.
%
% For example: [x, y] = meshgrid(-7:7,7:-1:7) would make a 15x15 template
% 
% func will be called as func(x,y,odiff,ori), where ori is the orientation
% of the subpopulation in from_pop and odiff is the difference in
% orientation between the from_pop subpopulation and the to_pop
% subpopulation. The output of this call is a subpopulation connection
% matrix. This is done for each combination of subpopulations in
% from_pop and to_pop.
%
% By Danny Jeck November 2014
% Created by Brian Hu for contour grouping cell to V1 edge cell feedback

if ~strcmp(from_pop.subpops(1).type,'orientation') || ~strcmp(to_pop.subpops(1).type,'orientation')
    error('two orientation populations required for gen_ori_conn');
end


ori1 = [from_pop.subpops(:).val];
ori2 = [to_pop.subpops(:).val];

conn = empty_conn;
conn.subpop_conn = empty_subpop_conn(length(ori2),length(ori1));

for o1 = 1:length(ori1)
    for o2 = 1:length(ori2)
        ori = ori2(o2);
        odiff = ori2(o2)-ori1(o1);
        
        conn.subpop_conn(o2,o1).matrix = func(x,y,odiff,ori,sd);
        conn.subpop_conn(o2,o1).scale = 1;
    end
end
