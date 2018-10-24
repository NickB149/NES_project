% Iterate over receivers
for i = 1 : size(Comm,2)
    % Iterate over senders
    for j = 1 : size(Comm,2)
        % Ignore sender when its the same message
        %if(i ~= j)
            % Test whether there is a collision
            % If there is a collision, attach ID of sender node that
            % creates this collision
             if (distance(Comm(i).sender,Comm(j).sender) <= Comm(i).sender.range || distance(Comm(i).sender,Comm(j).sender) <= Comm(j).sender.range )
                % Check if sender ID is not already in the list
                if (ismember(Comm(j).sender.ID,Comm(i).region) == 0)
                    Comm(i).region = [Comm(i).region,Comm(j).sender.ID];
                end               
            end
        %end
    end
end
%%
%Modify region column so that all the comms that collide in the same
%region are identified with the same region list
for i=1:size(Comm,2)
    Comm(i).region=[Comm(i).sender.ID, Comm(i).region];
    changed=1;
    while (changed)
        currsize=size(Comm(i).region,2);
        for j=1:size(Comm,2)
            for k=1:currsize
                if (ismember(Comm(i).region(k),Comm(j).region))
                    Comm(i).region=[Comm(i).region,Comm(j).region];
                end
            end          
        end
        Comm(i).region=unique(Comm(i).region);
        if (size(Comm(i).region)~=currsize)
            changed=1;
        else
            changed=0;
        end
        
    end
end
%%

numreg=0;
regionID(size(Comm,2))=0;
regions(2,size(Comm,2))=0;
for i=1:size(Comm,2)
    if (ismember(Comm(i).region,regions))
        for j=1:size(regions,1)
            if (ismember(Comm(i).region,regions(j,:)))
                regionID(i)=j;
                break;
            end
        end
    else
        regions(numreg+1,:)=[Comm(i).region , zeros(1,size(regions,2)-size(Comm(i).region,2))];
        numreg=numreg+1;
        regionID(i)=numreg;
    end
end

for i=1:size(Comm,2)
    Comm(i).region=[];
end
for i=1:size(Comm,2)
    Comm(i).region=regionID(i);
end
% Function that computes the Euclidian distance between two nodes 
function d = distance(n1, n2)
    d = norm(n1.pos - n2.pos);
end