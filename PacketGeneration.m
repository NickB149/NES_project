% clear all
% close all
% clc

%% 

choice = input('Menu:\n 1. Generate packets for all nodes\n 2. Generate packet for 1 node\n');

if choice ~= 1 && choice ~= 2
    disp('Invalid choice...Exiting program');
end

% Generate a packet for each node/tag
% Each packet contains: ID, price and description of the product
% nt = 8000;
if choice == 1
    Packets = struct('receiverID', {}, 'price', {}, 'desc', {});
    for i = 1 : nt
%         Packets(i).receiverID = i;
%         Packets(i).price = randi(60);
%         description = sprintf('Description of Packet for Node %d', i);
%         Packets(i).desc = description;
        Comm(i).ID = i;
        Comm(i).type = 'A';
        Comm(i).sender = node(i);
        Comm(i).receiver = [node(i+nNodes/2)];
        Comm(i).collision = [];

        Comm(i).latency = 0;
        Comm(i).time = 0;
        Comm(i).NB = 0;
        Comm(i).BE = 0;
        Comm(i).backoff = 0;
    end
else
%     targetNode = randi(8000);
%     promptText = sprintf('Generating packet for node %d', targetNode);
%     disp(promptText);
%     Packet.receiverID = targetNode;
%     Packet.price = randi(60);
%     Packet.desc = 'Details of Packet...';
    i = randi(8000);
    Comm(i).ID = i;
    Comm(i).type = 'A';
    Comm(i).sender = node(i);
    Comm(i).receiver = [node(i+nNodes/2)];
    Comm(i).collision = [];
    
    Comm(i).latency = 0;
    Comm(i).time = 0;
    Comm(i).NB = 0;
    Comm(i).BE = 0;
    Comm(i).backoff = 0;
end
