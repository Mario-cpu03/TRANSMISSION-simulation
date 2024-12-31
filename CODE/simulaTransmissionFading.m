%%
function meanPe=simulaTransmissionFading(A,SNRdB,Montecarlo,M);

% INPUT
% A= matrice dei simboli; 
% SNRdB= intervallo di Signal-to-Noise Ratio; 
% MonteCarlo= numero di simulazioni di trasmissione; 
% M= numero di simboli che posso trasmettere;

% OUTPUT
% meanPe= vettore delle probabilità di errore di simbolo per valore SNR,
%         con fading di Rayleigh;

%------------> Analisi delle probabilità di errore

SNR=10.^(SNRdB/10); %conversione SNRdB in SNR
for ii=1:length(SNRdB)%analisi delle probabilità di errore per SNR
    numErrori=0;
    

    for jj=1:Montecarlo %trasmissione per fissato SNR
        SNRF=-SNR(ii)*log(rand);
        N0=1/SNRF;
        noiseVariance=N0/2;
        
        symTx=A(randi(M),:);%simbolo trasmesso
        symRx=symTx+(sqrt(noiseVariance)*randn(1,size(A,2)));%simbolo ricevuto con rumore
        
        min_diff=Inf;
        for kk=1:M %decisore a minima distanza
            curr_diff=norm(symRx-A(kk,:));%calcolo della distanza tra i simboli aspettati e il simbolo ricevuto
            
            if curr_diff<min_diff
                min_diff=curr_diff;
                symsceltoRx=A(kk,:);%simbolo scelto per minima distanza al kk-esimo evento di trasmissione
            end
        end

        if ~isequal(symsceltoRx, symTx)%controllo degli errori
            numErrori=numErrori+1;
        end

    end
    meanPe(ii)=numErrori/Montecarlo;
end

end