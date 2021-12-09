function [ targetSeries, predictedSeries ] = MyModel( data )
%Do t�to funkce implementujte v� v�sledn� model pro predikci/regresi a
%ve�ker� algoritmy pro p�edzpracov�n� dat.

%Vstup:             data:           vstupn� surov� data reprezentuj�c� 1
%objekt (1 �asovou �adu, 1 pacienta, 1 obr�zek, apod.). 

%V�stup:            targetSeries:         "�asov� �ada" zaznamenan�ch po�t�
%medaili (dle datab�ze) v jednotliv�ch sezon�ch
%                   predictedSeries:      "�asov� �ada" predikovan�ch po�t� medaili dle algoritmu

% Koeficienty modelu pro tr�ninkovou mno�inu dat
B = [-15.6137613049507;
-15.1517765695532;
-14.4142442443700;
0.0119223034884745;
-0.125106918297551;
-0.0255536927059664;
-0.0146616223718558;
-0.0151226200210504;
-0.748258830603451];
% Vymaz�n� NaN hodnot
data = rmmissing(data,'DataVariables',{'NOC','Year','Season','Height','Weight','Age','Sex'});
% Vytvo�en� pomocn�ch prom�nn�ch pro predikci
L = size(data);
medal_value = zeros(L(1),1);
season = zeros(L(1),1);
gender = zeros(L(1),1);
team = zeros(L(1),1);
age = data.Age;
% Pomocn� vektor
data_to_prediction = [];
% P�i�azen� ��seln�ch hodnot podle jednotliv�ch kategori�
data.gender(strcmpi(data.Sex, "F")) = 1;
data.medal_value(strcmpi(data.Medal, "Gold")) =  3;
data.medal_value(strcmpi(data.Medal, "Silver")) =  2;
data.medal_value(strcmpi(data.Medal, "Bronze")) =  1;
data.medal_value(strcmpi(data.Medal, "NA")) =  0;
data.season(strcmpi(data.Season, "Summer")) =  1;
% Pomocn� prom�nn�
sezon_int = data.season;
gender_int = data.gender;
height = data.Height;
weight = data.Weight;
age_int = data.Age;
med_out = data.medal_value;
year = data.Year;
% Upraven� data vstupuj�c� do mnrval funkce
data_to_prediction = [table(year),table(sezon_int),table(height),table(weight),table(age_int),table(gender_int), table(med_out)];
% Data pro predikci
input_data = table2array(data_to_prediction(:,1:6));
% Skute�n� hodnoty medail�
actual_medal = table2array(data_to_prediction(:,7));
% Funkce pro ur�en� pravd�podobnosti z�sk�n� medaile
yhat = mnrval(B,input_data, "model", "ordinal");
% Sou�et predikovan�ch medail�
sum_of_predicted_medals = round(sum(yhat(:,2))) + round(sum(yhat(:,3))) + round(sum(yhat(:,4)));
% Funkce pro sou�et skute�n�ho po�tu medail�
targetSeries = GetTargetSeries(actual_medal);  
% V�stupn� hodnoty
predictedSeries = sum_of_predicted_medals;

end

function targetSeries = GetTargetSeries( input )
% Algoritmus pro ur�en� v�stupn� �asov� sekvence
    count = sum(input == 1) + sum(input == 2) + sum(input == 3);
% V�stupn� hodnoty
    targetSeries = count;

end