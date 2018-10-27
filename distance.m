% Function that computes the Euclidian distance between two nodes 
function d = distance(n1, n2)
    d = norm(n1.pos - n2.pos);
end