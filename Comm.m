%% Communication

%Find no of Regions
nRegions = size(regions,1);

commsToProcess = [];

%% Find comm with min time in each region
for i = 1 : nRegions
   time = 0;
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
               %hiddenNode = 1
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

Comm2 = Comm ;

%while (size(successfulComms,1) ~= 0)
  %  comm = size(successfulComms,1);
    
  %  Comm(comm) = [];
  %  successfulComms(comm) = [];
%end

for j = 1 : size(successfulComms,1)
    c  = successfulComms(j);
    Comm2(c) = [];
    
end