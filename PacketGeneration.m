% clear all
% close all
% clc

%% 

choice = input('Menu:\n 1. Generate packets for all nodes\n' ...
                '2. Generate packet for 1 node\n' ...
                '3. Generate packets from nodes based on #customers');

if choice ~= 1 && choice ~= 2 && choice ~= 3
    disp('Invalid choice...Exiting program');
end

% Generate a packet for each node/tag
% OLD: Each packet contains: ID, price and description of the product
% nt = 8000;
% Each Comm packet is initialized with: 
%     ID of the packet
%     type of the message: S2N - Server to Node, N2S - Node to Server
%     sender of the packet - ID of the server/node
%     receiver of the packet - entire path (list of IDs) from the server/node to node/server 
%     other fields are initialized with zero or empty

if choice == 1
    for i = 1 : nt
        Comm(i).ID = i;
        Comm(i).type = 'S2N';
        Comm(i).sender = server;
        Comm(i).receiver = [fliplr(cluster(node(i).clusterID).pathtoserver(1:end-1)), i];
        Comm(i).collision = [];
        Comm(j).region=[];
        
        Comm(i).latency = 0;
        Comm(i).time = 0;
        Comm(i).NB = 0;
        Comm(i).BE = 0;
        Comm(i).backoff = 0;
    end
elseif choice == 2
    i = randi(8000);
    Comm(i).ID = i;
    Comm(i).type = 'S2N';
    Comm(i).sender = server;
    Comm(i).receiver = [fliplr(cluster(node(i).clusterID).pathtoserver(1:end-1)), i];
    Comm(i).collision = [];
    Comm(j).region=[];
    
    Comm(i).latency = 0;
    Comm(i).time = 0;
    Comm(i).NB = 0;
    Comm(i).BE = 0;
    Comm(i).backoff = 0;
else
    num_customers = input('Enter the number of customers: ');
    avg_rate = num_customers * 1.5;
    rate = ceil(random('normal', rate, 1));
    for i = 1 : rate
        Comm(i).ID = i;
        Comm(i).type = 'N2S';
        Comm(i).sender = node(i);
        Comm(i).receiver = cluster(node(i).clusterID).pathtoserver;
        Comm(i).collision = [];
        Comm(j).region=[];

        Comm(i).latency = 0;
        Comm(i).time = 0;
        Comm(i).NB = 0;
        Comm(i).BE = 0;
        Comm(i).backoff = 0;

    end    
end





