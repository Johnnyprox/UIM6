function [ mae, mse, rmse ] = GetScoreOH( targetSeries, predictedSeries )
%Funkce pro vyhodnocen� �sp�nosti modelu

%Vstup:            targetSeries:        �asov� �ada zaznamenan�ch po�t� medaili v jednotliv�ch sezon�ch
%                  predictedSeries:     �asov� �ada predikovan�ch po�t� medaili v jednotliv�ch sezon�ch

%V�stup:           mae:                 St�edn� absolutn� chyba modelu
%                  mse:                 St�edn� kvadratick� chyba modelu
%                  rmse:                Sm�rodatn� odchylka residu�

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