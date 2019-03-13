function fit=compute_fitness(ff,flag)
% INTERNAL FUNCTION
%

if nargin<2
    
    flag=1;
    
end

switch flag
    
    case 1
        
        fit=nan(size(ff));
        
        pos=ff>=0;
        
        neg=~pos;
        
        fit(pos)=1./(1+ff(pos));
        
        fit(neg)=1+abs(ff(neg));
        
    case 2
        
        fit = exp(-ff/(1+max(abs(ff))));
        
    otherwise
        
        error([mfilename,':: unknown flag'])
        
end

end