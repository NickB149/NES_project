%just add the random backoff to the message.latency, than comm will solve
%it


%% csma ca calculation
%datatable
macMinBE=3; %0-3 (default 3)
aUnitBackoffPeriod= 20*16*10^-6; %symbol periods - 2.4ghz is 250 kbps, four data bits transfered each period => 16 microsecond / symbol
aMaxBE=5; %Max BE
macMaxCSMABackoffs= 4; % 0-5 (default:4)

%%1. init the parameters before wishing transmission | message.BE.NB
BE=macMinBE; %BE: Backoff Exponent
NB=0; %Number of succesful Backoffs

%%2. before transmission do a backoff for a random integer number between 0 and 2^BE-1

random=rand() %get a value between 0 and 1
waitingtime= (random*(2^BE-1)) * aUnitBackoffPeriod %RETURN BACKOFF TIME [seconds]

%%3 CCA = Clear Channel Assessment: if after 8 symbol periods the chanel is
%%busy both BE and NB incremented by one, up to aMaxBE and macMaxCSMABackoffs+1 for NB

%if CCA failed, so chanel not free:
BE=min((BE+1), aMaxBE);                             %RETURN NEW BE

if NB == (macMaxCSMABackoffs+1)
    %channel acces failure !!!!!! TODO: delete message, => init BE and NB
    %failure?                                      %RETURN NB
else
    NB=NB+1;                                        %RETURN NB                                       
end
%else - chanel free: send mesage and be happy

%%4. starting the transmission