%clear all
%close all
%clc

%% Generate test input data
% Create nodes
nNodes = 10;
placement = 30;
for i = 1 : nNodes
    node(i).ID = i;
    node(i).pos = [placement*rand,placement*rand];
end 

% list of nodes wanting to communicate
for j = 1 : nNodes/2
    Comm(j).ID = j;
    Comm(j).type = 'A';
    Comm(j).sender = node(j);
    Comm(j).senderID = node(j).ID; %Delete, only for debugging
    Comm(j).receiver = [node(j+nNodes/2)];
    Comm(j).collision = [];
    Comm(j).region=[];
    
    Comm(j).latency = 0;
    Comm(j).time = 0;
    Comm(j).NB = 0;
    Comm(j).BE = 3; %setting can vary 0-3 (default:3)
    Comm(j).backoff = 0;
end

for j = nNodes/2 : nNodes/2+5
    Comm(j).ID = nNodes/2 + j;
    Comm(j).type = 'B';
    Comm(j).sender = node(j);
    Comm(j).senderID = node(j).ID; %Delete, only for debugging
    Comm(j).receiver = [node(j-1), node(j-2)];
    Comm(j).collision = [];
    Comm(j).region=[];
    
    Comm(j).latency = 0;
    Comm(j).time = 0;
    Comm(j).NB = 0;
    Comm(j).BE = 3; %setting can vary 0-3 (default:3)
    Comm(j).backoff = 0;
end

%% Collision Detection
% Test if other sending nodes are in the interference range of
% communication nodes

% Assumptions:
% Receiver in the list is actually within the Communication Range of the sender

% Setup some variables
IR = 10; % Interference range

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
%% Iñaki Addition, check region, collision accessing medium by 2 senders
% Iterate over receivers
for i = 1 : size(Comm,2)
    % Iterate over senders
    for j = 1 : size(Comm,2)
        % Ignore sender when its the same message
        if(i ~= j)
            % Test whether there is a collision
            % If there is a collision, attach ID of sender node that
            % creates this collision
            if (distance(Comm(i).sender,Comm(j).sender) <= Comm(i).sender.range || distance(Comm(i).sender,Comm(j).sender) <= Comm(j).sender.range )
                % Check if sender ID is not already in the list
                if (ismember(Comm(j).sender.ID,Comm(i).region) == 0)
                    Comm(i).region = [Comm(i).region,Comm(j).sender.ID];
                end               
            end
        end
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
            Comm(i).region=unique(Comm(i).region);
        end
        if (size(Comm(i).region)~=currsize)
            changed=1;
        else
            changed=0;
        end
        
    end
end
            
                
% Function that computes the Euclidian distance between two nodes 
function d = distance(n1, n2)
    d = norm(n1.pos - n2.pos);
end
