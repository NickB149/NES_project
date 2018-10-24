clear all
close all
clc

%% Main Handler function

%% Set variables
% Node generation
nc=80; %Number of clusterheads
gridx=10; %Number of clusterheads in X coordinate
dis=10; %distance between clusterheads 
nt=8000; %Number of tags

range_of_clusterheads=25;%in meters
range_of_nodes=10;%in meters
range_of_server=50;%in meters

% Discovery
% Type of packets generated (1: all labels are updated, 2: single label is updated, 3: Customer based) 
PacketGenerationType = 1; 

% Init Backoff
macMinBE=3; %0-3 (default 3)
aUnitBackoffPeriod= 20*16*10^-6; %symbol periods - 2.4ghz is 250 kbps, four data bits transfered each period => 16 microsecond / symbol
aMaxBE=5; %Max BE
macMaxCSMABackoffs= 4; % 0-5 (default:4)

%% Generate nodes
NodeGeneration
%% Discovery
DiscoveryService

%% Generate packets
choice = PacketGenerationType;
PacketGeneration
%% Init Backoff
InitBackoff
%% Define Regions
%Region
%% Communincation
%Communication
