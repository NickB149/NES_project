% Convert ID to distance
function p = ID2Distance(id1, id2, node, cluster, server, nc)
    if (id1 == 0)
        n1 = server(1);
    elseif(id1 > 0 && id1 <= nc)
        n1 = cluster(id1);
    else
        n1 = node(id1-nc);
    end
    
    if (id2 == 0)
        n2 = server(1);
    elseif(id2 > 0 && id2 <= nc)
        n2 = cluster(id2);
    else
        n2 = node(id2-nc);
    end 
    p = norm(n1.pos - n2.pos);
end