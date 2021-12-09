function [ mae, mse, rmse, targetSeries, predictedSeries ] = Main( filePath )
%Funkce slou�� pro ov��en� predik�n�ch schopnost� navr�en�ho modelu.
%Model bude ov��ov�n na skryt� mno�in� dat, v odevzdan�m projektu je proto
%nutn� dodr�et sktrukturu tohoto k�du. 

%Vstup:     filePath:           N�zev slo�ky (textov� �et�zec) obsahuj�c� data

%V�stup:    mae:                 St�edn� absolutn� chyba modelu
%           mse:                 St�edn� kvadratick� chyba modelu
%           rmse:                Sm�rodatn� odchylka residu�
%           targetSeries:        Vstupn� "�asov� �ada"
%           predictedSeries:     Predikovan� "�asov� �ada"

%Funkce:    MyModel()           Funkce pro implementaci modelu a
%p�edzpracov�n� dat. Do funkce vstupuje v�dy jen 1 objekt (�asov� �ada, pacient, obr�zek, apod.)

%           GetScoreOH()          Funkce pro vyhodnocen� �sp�nosti
%           modelu. Z dostupn�ch hodnot vyberte do prezentace metriku
%           vhodnou pro va�e data (funkci neupravujte).


    %% Nastaven� cest a inicializace prom�nn�ch
% Doba b�hu    
    tic 
% Cesta k souboru
    filePath = pwd; 

    if ~isfolder( filePath )
        error('Folder does not exist.')
    end
% Na�ten� datov�ho souboru          
    inputData = readtable([ filePath '/' 'dataOH.csv' ]); 
% Dle zad�n� rok <= 2006
    inputData = inputData(inputData.Year <= 2006,:); 
% Unik�tn� n�zvy t�m�
    Teams = table(unique(inputData.NOC));   
% Unik�tn� hodnoty pro roky
    Years = unique(inputData.Year);    
% D�lka hodnot prom�nn� Teams     
    [numberRecords_teams, ~] = size(Teams);
% D�lka hodnot prom�nn� Years 
    numberRecords_years = length(Years);
% Pomocn� prom�nn� tabulky
    P = zeros(numberRecords_years,numberRecords_teams); 
    T = zeros(numberRecords_years,numberRecords_teams); 
% Pomocn� prom�nn� pro po��t�n� po�tu celkov�ch medail�    
    sum_target = 0; 
% Pomocn� prom�nn� pro po��t�n� po�tu predikovan�ch medail�
    sum_predicted = 0; 
    

% For cyklus pro po��t�n� jednotliv�ch predikc� zvl᚝ pro ka�d� rok a t�m 
    for y = 1:numberRecords_years
        data_year = inputData(inputData.Year == Years(y),:);        
        for t = 1:numberRecords_teams
            team_value = string(Teams.Var1);
            data_year_team = data_year(data_year.NOC == team_value(t),:);
            if isempty(data_year_team)
                continue
            else          
    
            %% Ur�en� v�stupu modelu pro 1 objekt
                [ targetSeries, predictedSeries ] = MyModel( data_year_team ); %V�stup modelu (predikce po�tu medaili) 

                sum_target = sum_target + targetSeries;
                sum_predicted = sum_predicted + predictedSeries;
                P(y,t) = predictedSeries;
                T(y,t) = targetSeries;

        
            %% Vyhodnocen� modelu

                [ mae, mse, rmse ] = GetScoreOH( targetSeries, predictedSeries );           
           
            end
        end
    end
% Ulo�en� tabulky predikovan�ch hodnot pro: ��dek = jednotliv� t�my, Sloupec = jednotliv� roky
    writetable(array2table(P),'Prediction_series.csv', 'Delimiter', ','); 
    writetable(array2table(T),'Target_series.csv', 'Delimiter', ',');
% V�po�et MAE, MSE, RMSE pro celkov� model zadan�ch hodnot
    [ mae, mse, rmse ] = GetScoreOH( sum_target, sum_predicted );
% V�pis v�sledku
    fprintf('Celkov� po�et predikovan�ch medail�: %d St�edn� absolutn� chyba modelu:  %d .\n',sum_predicted,mae)
% Doba b�hu
    toc
end



