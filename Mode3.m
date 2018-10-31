nc=app.nc; %Number of clusterheads
gridx=app.gridx; %Number of clusterheads in X coordinate
dis=app.dis; %distance between clusterheads 
nt=app.nt; %Number of tags

range_of_clusterheads=app.range_of_clusterheads;%in meters
range_of_nodes=app.range_of_nodes;%in meters
range_of_server=app.range_of_server;%in meters
commFailProb = app.commFailProb;
sim_time=app.sim_time;
num_customers = app.clients;
% Type of packets generated (1: all labels are updated, 2: single label is updated, 3: Customer based) 
PacketGenerationType = 3; 
% Init Backoff
macMinBE=3; %0-3 (default 3)
aUnitBackoffPeriod= (20*16*10^-6)*10^3; %symbol periods - 2.4ghz is 250 kbps, four data bits transfered each period => 16 microsecond / symbol. The times 10^3 makes this value [ms] ! from [s]
aMaxBE=5; %Max BE
macMaxCSMABackoffs= 4; % 0-5 (default:4)

%Repeat Packet Generation
rest=0;
global_time = 0;
last_gen_time = 0;
previous_time_goal=0;

% Comm

completedComms = [];
time_goal = 0;

%% Generate nodes
NodeGeneration
%% Discovery
DiscoveryService

%% Generate packets
if PacketGenerationType ~= 1 && PacketGenerationType ~= 2 && PacketGenerationType ~= 3
    disp('Invalid PacketGenerationType, must be {1,2,3}... Exiting program');
    return
end
PacketGeneration

%% Communication loop
while (1)
    if (size(Comm,2)~=0)
        %% Init Backoff
        InitBackoff
        %% Define Regions
        Regions
        %% Communincation
        Communication
        %% Fill the time with backoffs
        FillInBackoffs
    else
        time_goal=time_goal+10;
    end
        %% Repeat Packet Generation if it specified by the amount of customers present 
        if (PacketGenerationType == 3)
            RepeatPacketGeneration
            if (time_goal >= sim_time)
                disp('Script finished, timer ran out');
                app.comm_list=completedComms;
                app.pending=size(Comm,2);
                return
            end
        else % PacketGenerationType = {1,2}
            if (size(Comm,2)==0)
                disp('Script finished, Communication list is empty.');
                app.worst_latency=completedComms(size(completedComms,2)).latency;
                return
            end
        end
end
