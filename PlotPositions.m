%Plot everything - takes forever with the array of structs approach
hold on;
scatter3(S.position(1,1),S.position(1,2),S.position(1,3),100,'filled','g');
for i=1:nc
    scatter3(cluster(i).position(1),cluster(i).position(2),cluster(i).position(3),30,'b');
end
for i=1:nt
    scatter3(nodes(i).position(1),nodes(i).position(2),nodes(i).position(3),3,'r');
end
view(40,35)
    