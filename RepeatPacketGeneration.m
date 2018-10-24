%% This code generates the packets in the third scenario from the second iteration onwards

%last_gen_time = 0.0;

step_time = 1.0; %Why?
%global_time = 3.5;

%if (last_gen_time + step_time) >= global_time %I dont think the condition
%is necessary
    
    avg_rate = num_customers * 3.3333e-05; %In objects/milisecond
    rest = rest+random('raileigh', avg_rate);
    rate=floor(rest);
    rest=rest-rate;
    
    num_packets = size(Comm, 2);
    
    new_packets_start = num_packets + 1;
    new_packets_end = num_packets + rate;
    
    for i = new_packets_start : new_packets_end
        n=randi(8000);
        Comm(i).ID = i;
        Comm(i).type = 'N2S';
        Comm(i).sender = node(n));
        Comm(i).receiver = cluster(node(n).clusterID).pathtoserver;
        Comm(i).collision = [];
        Comm(i).region=[];

        Comm(i).latency = 0;
        Comm(i).time = global_time;
        Comm(i).NB = 0;
        Comm(i).BE = 0;
        Comm(i).backoff = 0;        
    end   
    last_gen_time=global_time;
%end