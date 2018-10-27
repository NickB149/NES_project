%% Regions
% Determine which senders are sending within the range of each other

%% Create list of the various senders
senders = Comm(1).sender.ID;
for i = 2 : size(Comm,2)
    if (ismember(Comm(i).sender.ID, senders) == 0)
        senders = [senders, Comm(i).sender.ID];
    end
end

% Prepare regions array
regions = -1 * ones(size(senders,2));
regions(:,1) = senders;
change = 1;

%% Create region array
% Iterate over regions list
% Repeat untill regions matrix doesn't change anymore
while (change == 1)
    change = 0;
    for i = 1 : size(regions,2)
        exit = 0;
        % Iterate over to be tested region list
        for k = i : size(regions,2)
            % Iterate over IDs that are in the same region
            for j = 1 : size(regions,2)
                if(regions(i,j) == -1 || exit == 1 || i == k)
                    break;
                end
                % Iterate over to be tested IDs that are in the same region
                for l = 1 : size(regions,2)
                    if(regions(k,l) == -1 || exit == 1)
                        break;
                    end
                    
                    % Compute distance between two senders
                    d = ID2Distance(regions(i,j),regions(k,l), node, cluster, server, nc);
                    if (d < ID2Range(regions(i,j), node, cluster, server, nc) || d < ID2Range(regions(k,l), node, cluster, server, nc))
                        change = 1;
                        % Combine the two regions, because they are in each
                        % others range
                        for x = 1 : size(regions,2)
                           % Find end of correct data
                           if(regions(i,x) == -1)
                               y = 1;
                               x1 = x;
                               while(regions(k,y) ~= -1)
                                   regions(i,x1) = regions(k,y); 
                                   y = y + 1;
                                   x1 = x1 + 1;
                               end
                               regions(k,:) = -1;
                               exit = 1;
                               break;
                           end
                       end
                    end
                end
            end
        end
    end
end

%% Cleanup region array
index = 1;
for i = 1 : size(regions,2)
   if(regions(i) ~= -1* ones(size(regions,2)))
       newRegions(index,:) = regions(i,:);
       index= index +1;
   end
end

regions = newRegions;

%% Compute region IDs used in Comm to be able to index regions from Comm.region
for i = 1:size(Comm,2)
   for j = 1:size(regions,1)
       if(ismember(Comm(i).sender.ID,regions(j,:)))
           Comm(i).region = j;
       end
   end
end