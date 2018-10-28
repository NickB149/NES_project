%% Filling random backofs calculation until we reach the communication time for all messages

%time_goal - need to fill  times for this, but must not increase above this
% for loop to keep adding backoff values to messages until all is bigger
% then the time measure
%TODO CHECK THE TIME GOAL OF MESSAGE , NOT A BACKOFF MAX TIME

for i = 1 : size(Comm,2) %iterate over the list
    if (Comm(i).time < time_goal) % if the time is behind the time_goal, so the atual time of the system
        while(Comm(i).time < time_goal) %keep addig backoffs until the time is higher than the goal
            Comm(i).NB = Comm(i).NB + 1; %add a backoff to this message
            Comm(i).BE=min( (Comm(i).BE+1), aMaxBE); %add BE value
        
            random_value=rand(); %get random 
            waitingtime = (random_value*((2^(Comm(i).BE))-1) * aUnitBackoffPeriod); %calculate backofftime
            Comm(i).backoff = waitingtime; %update the backoff time
            Comm(i).time = Comm(i).time + Comm(i).backoff;  % update the messages current time
            Comm(i).latency = Comm(i).latency + Comm(i).backoff; %add it to latency as well
            if (Comm(i).NB == (macMaxCSMABackoffs+1))
                %message failure TODO: add a number of failures?
                Comm(i).NB=0;
                Comm(i).BE=macMinBE;
                %do init backoff?? - doesnt matter basicly, if time is big
                %enought its just going to keep adding to it anyway
            end
        end
    end
end       
        
        