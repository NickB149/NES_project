%% Packet Generation
% Generate a packet for each node/tag
% OLD: Each packet contains: ID, price and description of the product
% nt = 8000;
% Each Comm packet is initialized with: 
%     ID of the packet
%     type of the message: S2N - Server to Node, N2S - Node to Server
%     sender of the packet - ID of the server/node
%     receiver of the packet - entire path (list of IDs) from the server/node to node/server 
%     other fields are initialized with zero or empty

% All labels are updated
if PacketGenerationType == 1
    for i = 1 : nt
        Comm(i).ID = i;
        Comm(i).type = 'S2N';
        Comm(i).sender = server;
        Comm(i).receiver = [fliplr(cluster(node(i).clusterID).pathtoserver(1:end-1)), i];
        Comm(i).collision = [];
        Comm(i).region=[];
        
        Comm(i).latency = 0;
        Comm(i).time = 0;
        Comm(i).NB = 0;
        Comm(i).BE = macMinBE;
        Comm(i).backoff = 0;
    end
    
% A single label is updated
elseif PacketGenerationType == 2
    i = randi(nt);
    Comm(1).ID = i;
    Comm(1).type = 'S2N';
    Comm(1).sender = server;
    Comm(1).receiver = [fliplr(cluster(node(i).clusterID).pathtoserver(1:end-1)), i];
    Comm(1).collision = [];
    Comm(1).region=[];
    
    Comm(1).latency = 0;
    Comm(1).time = 0;
    Comm(1).NB = 0;
    Comm(1).BE = macMinBE;
    Comm(1).backoff = 0;
    
% Packets generated based on amount of customers
else
    avg_rate = num_customers * 3.3333e-05; %In objects/milisecond
    rest = rest+random('Rayleigh', avg_rate);
    rate=floor(rest);
    rest=rest-rate;
    Comm = [];
    for i = 1 : rate
        n=randi(nt);
        Comm(i).ID = i;
        Comm(i).type = 'N2S';
        Comm(i).sender = node(n);
        Comm(i).receiver = cluster(node(n).clusterID).pathtoserver;
        Comm(i).collision = [];
        Comm(i).region=[];

        Comm(i).latency = 0;
        Comm(i).time = 0;
        Comm(i).NB = 0;
        Comm(i).BE = macMinBE;
        Comm(i).backoff = 0;
    end    
end