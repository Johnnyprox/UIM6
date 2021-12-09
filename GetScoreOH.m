function [ mae, mse, rmse ] = GetScoreOH( targetSeries, predictedSeries )
%Funkce pro vyhodnocení úspìšnosti modelu

%Vstup:            targetSeries:        èasová øada zaznamenaných poètù medaili v jednotlivých sezonách
%                  predictedSeries:     èasová øada predikovaných poètù medaili v jednotlivých sezonách

%Výstup:           mae:                 Støední absolutní chyba modelu
%                  mse:                 Støední kvadratická chyba modelu
%                  rmse:                Smìrodatná odchylka residuí

    if any( isnan( targetSeries ))
        error('Remove all NaN values from variable "targetSeries" before evaluation.')
    end
    
    if any( isnan( predictedSeries ))
        error('Remove all NaN values from variable "predictedSeries" before evaluation.')
    end
    
	targetSeries = targetSeries(:);
    predictedSeries = predictedSeries(:);

    mae = mean( abs( predictedSeries - targetSeries ));
    mse = mean(( predictedSeries - targetSeries ).^2 );
    rmse = sqrt( mse );
    
end