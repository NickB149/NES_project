%% Collision Detection
% Test if other sending nodes are in the interference range of
% communication nodes

% Assumptions:
% Receiver in the list is actually within the Communication Range of the sender

% Iterate over receivers
for i = 1 : size(Comm,2)
    % Iterate over senders
    for j = 1 : size(Comm,2)
        % Ignore sender when receiver is also a sender in the list or
        % when it is the correct sender
        if(Comm(i).receiver(1).ID ~= Comm(j).sender.ID && i ~= j)
            % Test whether there is a collision
            % If there is a collision, attach ID of sender node that
            % creates this collision
            if (distance(Comm(i).receiver(1),Comm(j).sender) <= Comm(j).sender.range)
                % Check if sender ID is not already in the list
                if (ismember(Comm(j).sender.ID,Comm(i).collision) == 0)
                    Comm(i).collision = [Comm(i).collision,Comm(j).sender.ID];
                end               
            end
        end
    end
end          