function [ mae, mse, rmse, targetSeries, predictedSeries ] = Main( filePath )
%Funkce slou�� pro ov��en� predik�n�ch schopnost� navr�en�ho modelu.
%Model bude ov��ov�n na skryt� mno�in� dat, v odevzdan�m projektu je proto
%nutn� dodr�et sktrukturu tohoto k�du. 

%Vstup:     filePath:           N�zev slo�ky (textov� �et�zec) obsahuj�c� data
filePath = pwd
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
    if ~isfolder( filePath )
        error('Folder does not exist.')
    end
        
    inputData = readtable([ filePath '/' 'dataOH.csv' ]); %Na�ten� datov�ho souboru 
    numberRecords = size( inputData, 1 ); % Zm�nit dle nutnosti  

    
    for idx = 1:numberRecords
        
    
        %% Ur�en� v�stupu modelu pro 1 objekt
        [ targetSeries, predictedSeries ] = MyModel( inputData ); %V�stup modelu (predikce po�tu medaili)

        
        %% Vyhodnocen� modelu
        [ mae, mse, rmse ] = GetScoreOH( targetSeries, predictedSeries );

    end


end



