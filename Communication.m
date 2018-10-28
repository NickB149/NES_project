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

for i = 1 : size(commsToProcess,1)
   c = commsToProcess(i);
   %sender = Comm(c).sender;
   receiver = Comm(c).receiver;
   hiddenNode = 0;
   
   for j = 1 : size(commsToProcess,1)
       if (j ~= i)
           c2 = commsToProcess(j);
           if (distance(Comm(c).receiver(1),Comm(c2).sender) <= Comm(c2).sender.range)
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

successfulComms = flipud(sort(successfulComms))
timeList = [];

for j = 1 : size(successfulComms,1)   
    
    c  = successfulComms(j);
    if ( size(Comm(c).receiver,2) > 1 )
        Comm(c).sender  = Comm(c).receiver(1);
        Comm(c).receiver(1) = [];
        commTime = 0;
        if (Comm(c).type == 'S2N')
            commTime = S2Ntime;
        else
            commTime = N2Stime;
        end
        Comm(c).time = Comm(c).time + commTime;
        timeList = [timeList Comm(c).time];
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
        timeList = [timeList Comm(c).time];
        completedComms = [completedComms Comm(c)];
        Comm2(c) = [];
    end    
end

commTime = max(timeList);
Comm = Comm2;
