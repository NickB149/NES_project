%Run the node_generation script, it must be in the same folder and the
%foldar must be added to the path
node_generation;
%%
%Get cluaterheads in range
N.clustersinrange(:,1)=1;
for i=1:nt
    for j=1:nc
        distance=norm(N.position(i,:)-CH.position(j,:));
        if distance<N.ranges
            N.clustersinrange(i,N.clustersinrange(i,1)+1)=j;
            N.clustersinrange(i,1)=N.clustersinrange(i,1)+1;
        end
    end
end

%%
%Choose one clusterhead at random
for i=1:nt
    index=randi([2,N.clustersinrange(i,1)]);
    N.clusterID(i)=N.clustersinrange(i,index);
end
N.clustersinrange(:,1)=[];
%%
CH.nodescomm(:,1)=1;
%Clusters get list of assigned nodes
for i=1:nt
    CH.nodescomm(N.clusterID(i),CH.nodescomm(N.clusterID(i),1)+1)=i;
    CH.nodescomm(N.clusterID(i),1)=CH.nodescomm(N.clusterID(i),1)+1;
end
%The following line removes the first column of the matrix, which is used
%in the previous lines to store the number of tags linked to each
%clusterhead. If you want to make use of it, comment it.
CH.nodescomm(:,1)=[]; 