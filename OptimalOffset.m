function [D,X,Y,off,bestVal] = OptimalOffset()

offset = (pi*5)/180;
bestVal = 0;

for n = 0:8
    [~,beam,~,x1,y1,~,optVal] = Optimizer(n*offset,0);
    if(n==0)
        bestVal = optVal;
        X = x1;
        Y = y1;
        D = beam;
    elseif(optVal > bestVal)
        bestVal = optVal;
        D = beam;
        off = n*5;
    end
end

end

