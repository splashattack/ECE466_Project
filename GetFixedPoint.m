function [Output] = GetFixedPoint(Input, WordLen, QNum)
    %% Initialize Parameters
    OutputBin = zeros([1,WordLen]);
    Output = 0;
    
    %% Set up output binary with Q number for abs(Input)
    Left=floor(abs(Input));
    LeftBin = bitget(Left,(WordLen-QNum):-1:1);
    
    Right = abs(Input)-Left;
    
    OutputBin = OutputBin + [LeftBin zeros([1,QNum])];
    
    for i=(WordLen-QNum)+1:1:WordLen
       Right = Right * 2;
       
       if Right >= 1
           Right = Right - 1;
           OutputBin(i) = 1;
       else
           OutputBin(i) = 0;
       end
    end
    
    %% Take 2's complement of output binary if needed
    if Input < 0
        % Take the 1's complement of OutputBin (negate all values)
        for i=1:1:WordLen
            if OutputBin(i) == 1
                OutputBin(i) = 0;
            elseif OutputBin(i) == 0
                OutputBin(i) = 1;
            end
        end
        
        % Take the 2's complement of OutputBin (add 1)
        OutputBin(WordLen) = OutputBin(WordLen) + 1;
        for i = WordLen:-1:2
            if OutputBin(i) == 2
                OutputBin(i) = 0;
                
                if i~=2
                    OutputBin(i-1) = OutputBin(i-1)+1;
                end
            end
        end   
    end
    
    %% Convert binary OutputBin into an integer number
    for i = 1:WordLen
        if OutputBin(i) == 1
            Output = Output + (2^(WordLen-i));
        end
    end
end
