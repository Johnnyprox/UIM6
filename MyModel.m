function [ targetSeries, predictedSeries ] = MyModel( data )
%Do t�to funkce implementujte v� v�sledn� model pro predikci/regresi a
%ve�ker� algoritmy pro p�edzpracov�n� dat.

%Vstup:             data:           vstupn� surov� data reprezentuj�c� 1
%objekt (1 �asovou �adu, 1 pacienta, 1 obr�zek, apod.). 
DataSummer = data(data.Season == "Summer",:);
roky = unique(DataSummer.Year);
number_of_years = length(roky);

teams = unique(DataSummer.NOC);

number_of_teams = length(teams);





R = zeros(number_of_years,number_of_teams,4);

for rok = 1:number_of_years
    for team = 1:number_of_teams
        [gold, silver, bronze, all] = sortingData(DataSummer, string(teams(team)), roky(rok));
        number_of_medals = [gold, silver, bronze, all];
        R(rok,team,1) = number_of_medals(1);
        R(rok,team,2) = number_of_medals(2);
        R(rok,team,3) = number_of_medals(3);
        R(rok,team,4) = number_of_medals(4);
    end

end




targetSeries = R;

x = R(:,:,1);
y = R(:,:,2);
z = R(:,:,3);
q = R(:,:,4);




figure("Name","Gold")
bar3(x)
xlabel("T�my")
ylabel("Roky")
zlabel("Po�et")
figure("Name","Silver")
bar3(y)
xlabel("T�my")
ylabel("Roky")
zlabel("Po�et")
figure("Name","Bronze")
bar3(z)
xlabel("T�my")
ylabel("Roky")
zlabel("Po�et")
figure("Name","All")
bar3(q)
xlabel("T�my")
ylabel("Roky")
zlabel("Po�et")

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