function [countFull] = sortingData(data)
%sorting Data: function for sorting data



Teamnames = unique(data);

y.medal_value(strcmpi(y.Medal, "Gold")) =  1;
y.medal_value(strcmpi(y.Medal, "Silver")) =  1;
y.medal_value(strcmpi(y.Medal, "Bronze")) =  1;
y.season(strcmpi(y.Season, "Summer")) =  1;




end

