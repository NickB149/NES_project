clear all
close all
clc

%% Main Handler function
% Function in which all input variables are initialized and other functions
% are called in the correc order.

%% Set variables
% Node generation
nc=80; %Number of clusterheads
gridx=10; %Number of clusterheads in X coordinate
dis=10; %distance between clusterheads 
nt=100; %Number of tags

range_of_clusterheads=25;%in meters
range_of_nodes=10;%in meters
range_of_server=50;%in meters

% Discovery
% Type of packets generated (1: all labels are updated, 2: single label is updated, 3: Customer based) 
PacketGenerationType = 3; 
num_customers = 0;
if(PacketGenerationType == 3 && num_customers == 0) 
    num_customers = input('Enter the number of customers: ');
end

% Init Backoff
macMinBE=3; %0-3 (default 3)
aUnitBackoffPeriod= (20*16*10^-6)*10^3; %symbol periods - 2.4ghz is 250 kbps, four data bits transfered each period => 16 microsecond / symbol. The times 10^3 makes this value [ms] ! from [s]
aMaxBE=5; %Max BE
macMaxCSMABackoffs= 4; % 0-5 (default:4)

%Repeat Packet Generation
rest=0;
global_time = 0;
last_gen_time = 0;
total_time = 100e3; % How long the script runs
previous_time_goal=0;

% Comm
commFailProb = 0.3;  % Probability that an attempted communication will fail
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
            if (time_goal >= total_time)
                disp('Script finished, timer ran out');
                return
            end
        else % PacketGenerationType = {1,2}
            if (size(Comm,2)==0)
                disp('Script finished, Communication list is empty.');
                return
            end
        end
end