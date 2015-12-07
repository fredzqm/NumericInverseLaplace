classdef simulator < handle
    
    properties (SetAccess = public)
        rel = [];
        f = comp(0);
        t = [];
    end
    
    methods
        function addR(this , addTo, coefficient , order , comps )
            newAdd.addTo = addTo ;
            newAdd.coefficient = coefficient ;
            newAdd.order = order ;
            newAdd.comps = comps ;
            this.rel = [this.rel newAdd]; 
        end
        
        function start(this)
            seg = size( this.f , 1 );
            for k = this.rel
                comps = [];
                for j = k.comps
                    comps = [ comps this.f(seg , j)];
                end
                this.f(seg , k.addTo).addR( k.coefficient, k.order , comps );
            end
        end
        
        function v = func(this , tt)
            v = tt ;
            seg = 1;
            lower = 0 ;
            upper = this.findThresh(1);
            for i = 1 : size(tt , 2)
                while tt(i) > upper
                    seg = seg + 1;
                    lower = upper;
                    upper = this.findThresh(seg);
                end
                v(i) = this.f(seg , 1).func( tt(i) - lower );
            end
        end
                
        function compute(this)
           for i = this.f
               i.compute();
           end 
        end
        
        function reset(this , resetTime)
            
            
            this.start();
        end
        
    end
    
    methods (Access = private)
       function thresh = findThresh(this, seg)
            if size(this.t , 2) < seg
                thresh = inf;
            else
                thresh = this.t(seg);
            end
        end 
    end
end