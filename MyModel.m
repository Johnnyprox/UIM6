function [ targetSeries, predictedSeries ] = MyModel( data )
%Do této funkce implementujte váš výsledný model pro predikci/regresi a
%veškeré algoritmy pro pøedzpracování dat.

%Vstup:             data:           vstupní surová data reprezentující 1
%objekt (1 èasovou øadu, 1 pacienta, 1 obrázek, apod.). 

%Výstup:            targetSeries:         "èasová øada" zaznamenaných poètù
%medaili (dle databáze) v jednotlivých sezonách
%                   predictedSeries:      "èasová øada" predikovaných poètù medaili dle algoritmu

% Koeficienty modelu pro tréninkovou množinu dat
B = [-15.6137613049507;
-15.1517765695532;
-14.4142442443700;
0.0119223034884745;
-0.125106918297551;
-0.0255536927059664;
-0.0146616223718558;
-0.0151226200210504;
-0.748258830603451];
% Vymazání NaN hodnot
data = rmmissing(data,'DataVariables',{'NOC','Year','Season','Height','Weight','Age','Sex'});
% Vytvoøení pomocných promìnných pro predikci
L = size(data);
medal_value = zeros(L(1),1);
season = zeros(L(1),1);
gender = zeros(L(1),1);
team = zeros(L(1),1);
age = data.Age;
% Pomocný vektor
data_to_prediction = [];
% Pøiøazení èíselných hodnot podle jednotlivých kategorií
data.gender(strcmpi(data.Sex, "F")) = 1;
data.medal_value(strcmpi(data.Medal, "Gold")) =  3;
data.medal_value(strcmpi(data.Medal, "Silver")) =  2;
data.medal_value(strcmpi(data.Medal, "Bronze")) =  1;
data.medal_value(strcmpi(data.Medal, "NA")) =  0;
data.season(strcmpi(data.Season, "Summer")) =  1;
% Pomocné promìnné
sezon_int = data.season;
gender_int = data.gender;
height = data.Height;
weight = data.Weight;
age_int = data.Age;
med_out = data.medal_value;
year = data.Year;
% Upravené data vstupující do mnrval funkce
data_to_prediction = [table(year),table(sezon_int),table(height),table(weight),table(age_int),table(gender_int), table(med_out)];
% Data pro predikci
input_data = table2array(data_to_prediction(:,1:6));
% Skuteèné hodnoty medailí
actual_medal = table2array(data_to_prediction(:,7));
% Funkce pro urèení pravdìpodobnosti získání medaile
yhat = mnrval(B,input_data, "model", "ordinal");
% Souèet predikovaných medailí
sum_of_predicted_medals = round(sum(yhat(:,2))) + round(sum(yhat(:,3))) + round(sum(yhat(:,4)));
% Funkce pro souèet skuteèného poètu medailí
targetSeries = GetTargetSeries(actual_medal);  
% Výstupní hodnoty
predictedSeries = sum_of_predicted_medals;

end

function targetSeries = GetTargetSeries( input )
% Algoritmus pro urèení výstupní èasové sekvence
    count = sum(input == 1) + sum(input == 2) + sum(input == 3);
% Výstupní hodnoty
    targetSeries = count;

end