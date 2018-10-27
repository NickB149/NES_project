%% DiscoveryService
% Determine which clusterheads are in range of the labels
% Determine which clusterheads are in range of other clusterheads
% Determine path from clusterheads to server

%% Get clusterheads in range of nodes 
for i=1:nt
    node(i).clustersinrange=[];
    for j=1:nc
        distance=norm(node(i).pos(:)-cluster(j).pos(:));
        if distance<node(i).range
            node(i).clustersinrange = [node(i).clustersinrange,j];
        end
    end
end

%% Choose one clusterhead at random
for i=1:nt
    index=randi([1,size(node(i).clustersinrange,2)]);
    node(i).clusterID=node(i).clustersinrange(index);
end

%% For each clusterhead, create a list of the nodes assigned to it
for i=1:nc
    cluster(i).nodesreg = [];
end
% Clusters get list of assigned nodes
for i=1:nt
    cluster(node(i).clusterID).nodesreg= [cluster(node(i).clusterID).nodesreg(), i];
end

%% Get clusterheads in range of clusterheads
for i=1:nc
    cluster(i).clustersinrange=[];
    for j=1:nc
        distance=norm(cluster(i).pos(:)-cluster(j).pos(:));
        if distance<cluster(i).range && i~=j
            cluster(i).clustersinrange= [cluster(i).clustersinrange,j];
        end
    end
end

%% Clusterhead in range of server
server.clustersinrange=[];
for j=1:nc
    distance=norm(server.pos(:)-cluster(j).pos(:));
    if distance<server.range
        server.clustersinrange=[server.clustersinrange,j];
    end
end 

%% Get path to server from any cluster
for i=1:nc
    distance=norm(cluster(i).pos(:)-server.pos(:));
    
    if distance<cluster(i).range && distance<server.range
        % Direct connection to server
        cluster(i).pathtoserver=[i, 0];
    else
        % Connection to server via other clusterheads
        % ??? This assumes incorrectly that a cluster with lower number is
        % closer to the server, right?
        cluster(i).pathtoserver=[i,cluster(min(cluster(i).clustersinrange)).pathtoserver];
    end
end
