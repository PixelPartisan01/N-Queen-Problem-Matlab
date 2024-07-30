%------------------------------------------------%
%A program a gépemen 12-17 másodperc alatt fut le%
%           CPU - Intel Core i5-9300H            %
%************************************************%
%   Az x vektorban az értékek indexei a sorok,   %
%   maguk az értékek pedig az oszlopok indexei.  %
%       pl.: x(1) = 9 -> 1. sor, 9. oszlop       %
%               [vagy fordítva]                  %
%------------------------------------------------%

function [x,Ex] = queen(n)
    
    x = randperm(n);
    Ex = energy(x);
    xbest = x;
    Exbest = Ex;
    T = 1;
    coolingRate = 0.95;
    
    while T > 0 && Exbest > 0
        for fl = 1:20
            x_new = x;

            i = round(unifrnd(1,n));
            j = round(unifrnd(1,n));
            x_new([i j]) = x_new([j i]);
            
            Ex_new = energy(x_new);
            deltaE = Ex_new - Ex;
            
            if deltaE < 0
                x = x_new;
                Ex = Ex_new;
                xbest = x;
                Exbest = Ex;
            else
                p = exp(-deltaE/T);
                if rand() < p
                    x = x_new;
                    Ex = Ex_new;
                end
            end

            if Exbest == 0
                break;
            end
        end

        T =  T * coolingRate;
        
    end
    x = xbest; % eddig talált legjobb permutáció ...
    Ex = Exbest; % ... és annak energiája.
end

function Ex = energy(x)
    n = length(x);
    Ex = 0;
    for i = 1:n
        for j = i+1:n
            if x(i) == x(j) || abs(x(i)-x(j)) == abs(i-j)
                Ex = Ex + 1;
            end
        end
    end
end