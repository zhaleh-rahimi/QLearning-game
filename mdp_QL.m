function [Q,V,policy]= mdp_QL(R,discount)
n=1;k=3;N=51;
maxIter=1e4;
Q=zeros(N+1,k);
while n<maxIter
    game_over=false;
    s=N+1;
    while ~game_over
        % Action choice : greedy with increasing probability
        % probability epsilon= 1-(1/log(n+2))
        pn = rand(1);
        epsilon=1-(1/log(n+2));
        if (pn < (1-epsilon/2))
            [~,a] = max(Q(s,:));
        else
            a = randi(k);
        end
        s_new=s-a;
        
        alpha =1/sqrt(n+2);

        if(s_new <= 1) %QL loses
            Q(s,a) = Q(s,a)-alpha*(1+Q(s,a));
            break;
        end

        %simulate opponent's move
        a_op=randi(k);
        s_op= s_new - a_op;

        if(s_op <= 1) %QL wins
            Q(s,a) = Q(s,a)+ alpha*(1 - Q(s,a));
            break;
        else
            Q(s,a) = Q(s,a)+ alpha*(R(s,s_new,a) + ...
                discount*max(Q(s_op,:)) - Q(s,a));
        end
        s=s_op;
    end
    n=n+1;
end
[V, policy] = max(Q,[],2);
end

