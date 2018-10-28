%% InitBackoff
% Add a random backoff to the message.latency and message.time, Communication will solve it

%% CSMA CA calculation
for i = 1 : size(Comm,2)
    if(Comm(i).NB == 0) %if the message is just created, so its initalized (%%2. before transmission do a backoff for a random integer number between 0 and 2^BE-1)
        random_value=rand();
        waitingtime = (random_value*((2^(Comm(i).BE))-1) * aUnitBackoffPeriod);
        
        Comm(i).backoff = waitingtime;
        Comm(i).time = Comm(i).time + Comm(i).backoff;
        Comm(i).latency = Comm(i).latency + Comm(i).backoff;
    end
end