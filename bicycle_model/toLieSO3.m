function w = toLieSO3(W)
% 
% w = toLieSO3(W)
% Converts three element SO(3) matrix W to 3x3 so(3) Lie algebra w
% 
w = zeros(3,3);
if ((size(W,1) == 1)&&(size(W,2) == 3))||((size(W,2) == 1)&&(size(W,1) == 3))
    w = [0  , -W(3) ,W(2);...
        W(3),  0    ,-W(1);...
       -W(2), W(1)  ,0    ];
else
    w = null(1);
end