function [ ssd ] = SSDmatch( m1, m2 )
 
    win=m1-m2;
    ssd = sum(sum(win .^2));

end

