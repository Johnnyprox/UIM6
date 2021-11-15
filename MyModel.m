function [ targetSeries, predictedSeries ] = MyModel( data )
%Do t�to funkce implementujte v� v�sledn� model pro predikci/regresi a
%ve�ker� algoritmy pro p�edzpracov�n� dat.

%Vstup:             data:           vstupn� surov� data reprezentuj�c� 1
%objekt (1 �asovou �adu, 1 pacienta, 1 obr�zek, apod.). 

[gold, silver, bronze, all] = sortingData(data, "CZE", 2000);   

targetSeries = [gold, silver, bronze, all];



%V�stup:            targetSeries:         "�asov� �ada" zaznamenan�ch po�t�
%medaili (dle datab�ze) v jednotliv�ch sezon�ch
%                   predictedSeries:      "�asov� �ada" predikovan�ch po�t� medaili dle algoritmu

% targetSeries = GetTargetSeries( ... ); % doplnit pot�ebn� vstupn� prom�nn�
% predictedSeries = [];
% 
% end
% 
% function targetSeries = GetTargetSeries( input )
% %Do t�to funkce dopl�te algoritmus pro ur�en� v�stupn� �asov� sekvence
% %po�t� medaili ze surov�ch dat, dostupn�ch pro jednotliv� jedince.
% 
%     targetSeries = [];

end