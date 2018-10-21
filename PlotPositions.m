%Plot everything - takes forever with the array of structs approach
hold on;
scatter3(server.pos(1),server.pos(2),server.pos(3),100,'filled','g');
for i=1:nc
    scatter3(cluster(i).pos(1),cluster(i).pos(2),cluster(i).pos(3),30,'b');
end
for i=1:nt
    scatter3(node(i).pos(1),node(i).pos(2),node(i).pos(3),3,'r');
end
view(40,35)
    