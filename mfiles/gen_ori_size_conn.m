function conn = gen_ori_size_conn(from_pop,to_pop,func,r0)
% conn = gen_ori_size_conn(from_pop,to_pop,func,r0)
% Creates a connection structure between an orientation population and a
% size population. onnection runs from from_pop to to_pop and is defined 
% in terms of the output of the function handle func. r0 is the radius of
% the size population that has the same scale as the orientation
% population. 
%
% func will be called as func(ori,r), where r is the radius of the size
% population and ori is the angle of the orientation population.
%
% By Danny Jeck November 2014


%figure out which population varies in size and which has orientations
if strcmp(from_pop.subpops(1).type,'size')
    size_pop  = from_pop;
    size_flag = 1;
elseif strcmp(to_pop.subpops(1).type,'size')
    size_pop  = to_pop;
    size_flag = 2;
else
    error('no population based on size');
end

if strcmp(from_pop.subpops(1).type,'orientation')
    ori_pop  = from_pop;
elseif strcmp(to_pop.subpops(1).type,'orientation')
    ori_pop  = to_pop;
else
    error('no population based on orientation');
end

r_list = [size_pop.subpops(:).val];
ori_list = [ori_pop.subpops(:).val];

conn = empty_conn;
conn.subpop_conn = empty_subpop_conn(length(to_pop.subpops),length(from_pop.subpops));

for ss1 = 1:length(from_pop.subpops)
    for ss2 = 1:length(to_pop.subpops)
        if size_flag == 1
            r = r_list(ss1);
            ori = ori_list(ss2);
            conn.subpop_conn(ss2,ss1).scale = r/r0;
        else
            r = r_list(ss2);
            ori = ori_list(ss1);
            conn.subpop_conn(ss2,ss1).scale = r0/r;
        end
        conn.subpop_conn(ss2,ss1).matrix = func(ori,r);        

    end
end