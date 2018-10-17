clear all
close all
clc
%%
%Parameters for the generation
nc=80; %Number of clusterheads
gridx=10; %Number of clusterheads in X coordinate
dis=10; %distance between clusterheads 
nt=8000; %Number of tags

range_of_clusterheads=25;%in meters
range_of_nodes=10;%in meters
range_of_server=50;%in meters
%%
%Structs initialization
CH.position(nc,3)=0;
CH.ranges=range_of_clusterheads;
CH.nodescomm(nc,1)=0;

N.clustersinrange(nt,1)=0;
N.clusterID(nt,1)=0;
N.position(nt,3)=0;
N.ranges=range_of_nodes;
%%
%Coordinators generation
gridy=nc/gridx;
z=3;
x=dis/2;
y=dis/2;
for i=1:gridx
    for j=1:gridy
        CH.position((i-1)*gridy+j,:)=[x,y,z];
        y=y+dis;
    end
    y=dis/2;
    x=x+dis;
end

%%
%Node generator with no cluster dependency
N.position=[gridx*dis*rand(nt,1), gridy*dis*rand(nt,1), 2*rand(nt,1)];
%%
%Server node
S.position=[0,0,1];
S.range=range_of_server;
%%
%Plot everything
hold on;
scatter3(S.position(1,1),S.position(1,2),S.position(1,3),100,'filled','g');
scatter3(CH.position(:,1),CH.position(:,2),CH.position(:,3),30,'b');
scatter3(N.position(:,1),N.position(:,2),N.position(:,3),3,'r');
view(40,35)
    



