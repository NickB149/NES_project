%Run the node_generation script, it must be in the same folder and the
%folder must be added to the path
%NodeGeneration;
%%
%Get cluaterheads in range of nodes 

for i=1:nt
    node(i).clustersinrange(1)=1;
    for j=1:nc
        distance=norm(node(i).pos(:)-cluster(j).pos(:));
        if distance<node(i).range
            node(i).clustersinrange(node(i).clustersinrange(1)+1)=j;
            node(i).clustersinrange(1)=node(i).clustersinrange(1)+1;
        end
    end
end



%%
%Choose one clusterhead at random
for i=1:nt
    index=randi([2,node(i).clustersinrange(1)]);
    node(i).clusterID=node(i).clustersinrange(index);
    node(i).clustersinrange(1)=[];
end
%%
cluster(nc).nodesreg(1)=1;
for i=1:nc-1
    cluster(i).nodesreg(1)=1;
end
%Clusters get list of assigned nodes
for i=1:nt
    cluster(node(i).clusterID).nodesreg(cluster(node(i).clusterID).nodesreg(1)+1)=i;
    cluster(node(i).clusterID).nodesreg(1)=cluster(node(i).clusterID).nodesreg(1)+1;
end
%The following line removes the first column of the matrix, which is used
%in the previous lines to store the number of tags linked to each
%clusterhead. If you want to make use of it, comment it.
for i=1:nc
    cluster(i).nodesreg(1)=[];
end
%%
%Get clusterheads in range of clusterheads

for i=1:nc
    cluster(i).clustersinrange(1)=1;
    for j=1:nc
        distance=norm(cluster(i).pos(:)-cluster(j).pos(:));
        if distance<cluster(i).range && i~=j
            cluster(i).clustersinrange(cluster(i).clustersinrange(1)+1)=j;
            cluster(i).clustersinrange(1)=cluster(i).clustersinrange(1)+1;
        end
    end
    
    cluster(i).clustersinrange(1)=[];
end

server.clustersinrange(1)=1;
for j=1:nc
    distance=norm(server.pos(:)-cluster(j).pos(:));
    if distance<server.range
        server.clustersinrange(server.clustersinrange(1)+1)=j;
        server.clustersinrange(1)=server.clustersinrange(1)+1;
    end
end
server.clustersinrange(1)=[]; 
%get path to server
for i=1:nc
    distance=norm(cluster(i).pos(:)-server.pos(:));
    if distance<cluster(i).range && distance<server.range
        cluster(i).pathtoserver=[i, 0];
    else
        cluster(i).pathtoserver=[i,cluster(min(cluster(i).clustersinrange)).ID,cluster(min(cluster(i).clustersinrange)).pathtoserver(2:end)];
    end
end
