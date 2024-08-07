clc;close all; clear;
N=51;k=3;
[T,R]=tr(N,k);
discount=0.99;
[Q,V,policy]= mdp_QL(R,discount);

iter=1e3;
winner= zeros(iter,1);

%test
for i=1:iter
    states=N+1;
    remainder=N;
    player=true;
    %fprintf("%10s%15s\n","Takes","Remains");
    %fprintf("------------------------------------\n");
    while(remainder >=1)
        if(player)
            action= policy(states);%QL
            states=states-action;
            remainder=states-1;
            %fprintf("Player%-10d%10d%15d\n",player,action,remainder);
            player=~player;
        else
            if(states>=1)
                action= Player2(k,states);%random
                states=states-action;
                remainder=states-1;
                %fprintf("Player%-10d%10d%15d\n",player,action,remainder);
                player=~player;
            else
                break;
            end
        end
    end
    lastPlayer=~player;
    if(remainder == 1)
        winner(i) = lastPlayer;
    elseif(remainder <=0)
        winner(i) = ~lastPlayer;
    end
end

%plot win vs lose
C = categorical(winner,[1 0],{'Qlearner wins','Random wins'});
figure(1)
histogram(C,'BarWidth',0.5)
title("QLearner vs Random player win in 100 tests")

fprintf("QLearner vs Randoms wins %.2f%% of the times in %d runs\n", ...
    length(find(winner==1))*100/iter,iter);

%show heatmap of final value matrix
figure(2)
heatmap(Q')
xlabel("Ramining stones");ylabel("Action")
title("Qtable of QLearner")

%%
function [T,R]= tr(N,k)
R=zeros(N+1,N+1,k);T=R;
for j=1:N+1
    for i=1:k
        if(j >i)
            T(j,j-i,i)=1;
        end
    end
end
for i=1:k
    R(i+1,1,i)=-1;
    R(i+2,2,i)=1;
end
end
%%
function a= Player2(k,N)
a=randi(k);
if(a >= N && N >1)
    a = N-1;
elseif(N <= a && N <2)
    a=1;
end
end
