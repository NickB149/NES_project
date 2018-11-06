%% Node Generation
% Generates and initializes the array of structs about the clusterheads and labels

%% Structs initialization
% Clusters will have the properties - cluster ID, type identifier, range,
% position and nodes registered to it
global cluster
global node
global server
cluster(nc).ID=nc;
cluster(nc).type='cluster';
cluster(nc).pos(3)=0;
cluster(nc).range=range_of_clusterheads;
cluster(nc).nodesreg=0;

%Nodes will have the properties - Node ID, type identifier, position,
%range, ID of head cluster and no of clusters in range
node(nt).ID=nt;
node(nt).type='node';
node(nt).pos(3)=0;
node(nt).range=range_of_nodes;
node(nt).clustersinrange=0;
node(nt).clusterID=0;

%% Ranges
% To simulate real products, the range of all clusterheads and nodes will
% not be an exact value. Rather their ranges will be normally distributed
% with a mean value and standard deviation
for i=1:nc
    cluster(i).range=random('normal',range_of_clusterheads,1);
end
for i=1:nt
    node(i).range=random('normal',range_of_nodes,0.2);
end

%% Clusterheads generation
% Distribute clusterheads evenly among the entire area
gridy=nc/gridx;
z=3;
x=dis/2;
y=dis/2;
for i=1:gridx
    for j=1:gridy
        cluster((i-1)*gridy+j).ID=(i-1)*gridy+j;
        cluster((i-1)*gridy+j).type='cluster';
        cluster((i-1)*gridy+j).pos=[x,y,z];
        y=y+dis;
    end
    y=dis/2;
    x=x+dis;
end

%% Node generator with no cluster dependency
for i=1:nt
    node(i).type='node';
    node(i).ID=nc+i;
    node(i).pos=[gridx*dis*rand(1), gridy*dis*rand(1), 2*rand(1)];
end

%% Server node
%Only one server node which will be the PAN coordinator of the tree
%structure

cluster(nc+1).pos=[0,0,1];
cluster(nc+1).range=range_of_server;
cluster(nc+1).type='server';
cluster(nc+1).nodesreg=[];
cluster(nc+1).pathtoserver=[];
cluster(nc+1).clustersinrange=[];
cluster(nc+1).ID=0;
server=cluster(nc+1);
cluster(nc+1)=[];

%% Plot everything - takes forever with the array of structs approach
%PlotPositions;
    



