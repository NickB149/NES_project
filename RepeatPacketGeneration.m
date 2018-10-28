%% This code generates the packets in the third scenario from the second iteration onwards



%if (last_gen_time + step_time) >= global_time %I dont think the condition
%is necessary
    
   rate = num_customers * 3.3333e-05 * (time_goal-previous_time_goal); %In people * packets/(people* milisecond) * milisecons = packets
    %rest = rest+random('Rayleigh', avg_rate);
    rate=floor(rate);
    %rest=rest-rate;
    if (rate~=0)
    num_packets = size(Comm, 2);
    
    new_packets_start = num_packets + 1;
    new_packets_end = num_packets + rate;
    
    for i = new_packets_start : new_packets_end
        n=randi(nt);
        Comm(i).ID = i;
        Comm(i).type = 'N2S';
        Comm(i).sender = node(n);
        Comm(i).receiver = cluster(node(n).clusterID).pathtoserver;
        Comm(i).collision = [];
        Comm(i).region=[];

        Comm(i).latency = 0;
        Comm(i).time = time_goal;
        Comm(i).NB = 0;
        Comm(i).BE = macMinBE;
        Comm(i).backoff = 0;        
    end   
    
        previous_time_goal=time_goal;
    end
%end