% Convert ID to Range
function r = ID2Range(id, node, cluster, server, nc)
    if (id == 0)
        r = server(1).range;
    elseif(id > 0 && id <= nc)
        r = cluster(id).range;
    else
        r = node(id-nc).range;
    end
end