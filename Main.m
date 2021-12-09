function [ mae, mse, rmse, targetSeries, predictedSeries ] = Main( filePath )
%Funkce slouží pro ovìøení predikèních schopností navrženého modelu.
%Model bude ovìøován na skryté množinì dat, v odevzdaném projektu je proto
%nutné dodržet sktrukturu tohoto kódu. 

%Vstup:     filePath:           Název složky (textový øetìzec) obsahující data

%Výstup:    mae:                 Støední absolutní chyba modelu
%           mse:                 Støední kvadratická chyba modelu
%           rmse:                Smìrodatná odchylka residuí
%           targetSeries:        Vstupní "èasová øada"
%           predictedSeries:     Predikovaná "èasová øada"

%Funkce:    MyModel()           Funkce pro implementaci modelu a
%pøedzpracování dat. Do funkce vstupuje vždy jen 1 objekt (èasová øada, pacient, obrázek, apod.)

%           GetScoreOH()          Funkce pro vyhodnocení úspìšnosti
%           modelu. Z dostupných hodnot vyberte do prezentace metriku
%           vhodnou pro vaše data (funkci neupravujte).


    %% Nastavení cest a inicializace promìnných
% Doba bìhu    
    tic 
% Cesta k souboru
    filePath = pwd; 

    if ~isfolder( filePath )
        error('Folder does not exist.')
    end
% Naètení datového souboru          
    inputData = readtable([ filePath '/' 'dataOH.csv' ]); 
% Dle zadání rok <= 2006
    inputData = inputData(inputData.Year <= 2006,:); 
% Unikátní názvy týmù
    Teams = table(unique(inputData.NOC));   
% Unikátní hodnoty pro roky
    Years = unique(inputData.Year);    
% Délka hodnot promìnné Teams     
    [numberRecords_teams, ~] = size(Teams);
% Délka hodnot promìnné Years 
    numberRecords_years = length(Years);
% Pomocná promìnná tabulky
    P = zeros(numberRecords_years,numberRecords_teams); 
    T = zeros(numberRecords_years,numberRecords_teams); 
% Pomocná promìnná pro poèítání poètu celkových medailí    
    sum_target = 0; 
% Pomocná promìnná pro poèítání poètu predikovaných medailí
    sum_predicted = 0; 
    

% For cyklus pro poèítání jednotlivých predikcí zvláš pro každý rok a tým 
    for y = 1:numberRecords_years
        data_year = inputData(inputData.Year == Years(y),:);        
        for t = 1:numberRecords_teams
            team_value = string(Teams.Var1);
            data_year_team = data_year(data_year.NOC == team_value(t),:);
            if isempty(data_year_team)
                continue
            else          
    
            %% Urèení výstupu modelu pro 1 objekt
                [ targetSeries, predictedSeries ] = MyModel( data_year_team ); %Výstup modelu (predikce poètu medaili) 

                sum_target = sum_target + targetSeries;
                sum_predicted = sum_predicted + predictedSeries;
                P(y,t) = predictedSeries;
                T(y,t) = targetSeries;

        
            %% Vyhodnocení modelu

                [ mae, mse, rmse ] = GetScoreOH( targetSeries, predictedSeries );           
           
            end
        end
    end
% Uložení tabulky predikovaných hodnot pro: Øádek = jednotlivé týmy, Sloupec = jednotlivé roky
    writetable(array2table(P),'Prediction_series.csv', 'Delimiter', ','); 
    writetable(array2table(T),'Target_series.csv', 'Delimiter', ',');
% Výpoèet MAE, MSE, RMSE pro celkový model zadaných hodnot
    [ mae, mse, rmse ] = GetScoreOH( sum_target, sum_predicted );
% Výpis výsledku
    fprintf('Celkový poèet predikovaných medailí: %d Støední absolutní chyba modelu:  %d .\n',sum_predicted,mae)
% Doba bìhu
    toc
end



