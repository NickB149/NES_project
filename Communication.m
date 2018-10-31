%% Communication

S2Ntime = 4.8;

N2Stime = 1.28 ;

%Find no of Regions
nRegions = size(regions,1);

commsToProcess = [];

%% Find comm with min time in each region
for i = 1 : nRegions
   time = 10000000000000000000000000000;
   comm = -1;
   for j = 1 : size(Comm,2)
       if (Comm(j).region == i)
           if (Comm(j).time <= time)
               comm = j;
               time = Comm(j).time;             
           end
       end
   end
   commsToProcess = [commsToProcess ; comm];
end

%% Process one communication in each region and check for hidden nodes
% then find which nodes can successfully communicate based on probablity
successfulComms = [];
timeList = [];
for i = 1 : size(commsToProcess,1)
   c = commsToProcess(i);
   %sender = Comm(c).sender;
   receiver = Comm(c).receiver;
   hiddenNode = 0;
   commTime = 0;
    if (Comm(i).type == 'S2N')
        commTime = S2Ntime;
    else
        commTime = N2Stime;
    end
    Comm(i).time = Comm(c).time + commTime;
    Comm(i).latency = Comm(c).latency + commTime;
    timeList = [timeList Comm(c).time];
   for j = 1 : size(commsToProcess,1)
       if (j ~= i)
           c2 = commsToProcess(j);
           if (ID2Distance(Comm(c).receiver(1),Comm(c2).sender.ID, node, cluster, server, nc) <= Comm(c2).sender.range)
                   hiddenNode = 1;
           end
       end
   end
   
   if (hiddenNode == 0)
       p = rand;
       if ( p > commFailProb)
           successfulComms = [successfulComms; c ];
       end
   end
   
end

successfulComms = flipud(sort(successfulComms));
% timeList = [];

for j = 1 : size(successfulComms,1)   
    
    c  = successfulComms(j);
    if ( size(Comm(c).receiver,2) > 1 )
        Comm(c).sender  = cluster(Comm(c).receiver(1));
        Comm(c).receiver(1) = [];
%         commTime = 0;
%         if (Comm(c).type == 'S2N')
%             commTime = S2Ntime;
%         else
%             commTime = N2Stime;
%         end
%         Comm(c).time = Comm(c).time + commTime;
%         Comm(c).latency = Comm(c).latency + commTime;
%         timeList = [timeList Comm(c).time];
    end    
end

Comm2 = Comm ;

for j = 1 : size(successfulComms,1)   
    
    c  = successfulComms(j);
    if ( size(Comm(c).receiver,2) == 1 )
        commTime = 0;
        if (Comm(c).type == 'S2N')
            commTime = S2Ntime;
        else
            commTime = N2Stime;
        end
        Comm(c).time = Comm(c).time + commTime;
        Comm(c).latency = Comm(c).latency + commTime;
        timeList = [timeList Comm(c).time];
        completedComms = [completedComms Comm(c)];
        Comm2(c) = [];
    end    
end
if (size(timeList)~=0)
    time_goal = max(timeList);
end
Comm = Comm2;
