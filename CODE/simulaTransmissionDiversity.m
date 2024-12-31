% Si implementi una tecnica di diversità temporale(Diversità temporale). 
% Ciò significa che lo stesso segnale viene trasmesso più volte(L volte) in momenti diversi. Quindi in ricezione, 
% tra le diverse versioni ricevute dello stesso segnale, viene scelta quella che ha il rapporto segnale-rumore (SNR) 
% più ALTO, poiché è quella che ha subito il minore degrado da parte del fading.

function meanPe=simulaTransmissionDiversity(A,SNRdB,Montecarlo,M,L);

% INPUT
% A= matrice dei simboli;
% SNRdB= intervallo di Signal-to-Noise Ratio; 
% MonteCarlo= numero di simulazioni di trasmissione; 
% M= numero di simboli che posso trasmettere; 
% L= numero di ritrasmissioni per simbolo (diversità); 

% OUTPUT
% meanPe= vettore delle probabilità di errore di simbolo per SNR con
%         tecnica di diversità; 
%       

%------------> Analisi delle probabilità di errore
SNR=10.^(SNRdB/10); %conversione SNRdB in SNR
for ii=1:length(SNRdB)%analisi delle probabilità di errore per SNR
    numErrori=0;
    

    for jj=1:Montecarlo %trasmissione per fissato SNR
        % Inizializzazione per diversità
        best_SNRF = -Inf; %Imposto il valore migliore di SNR ad un numero molto basso, per assicurarmi che qualsiasi trasmissione lo superi.
        best_symRx = [];   % Memorizza il simbolo ricevuto con il miglior SNR
        
        for l=1:L % Ciclo per la diversità (L trasmissioni)
            SNRF=-SNR(ii)*log(rand); % SNR con fading per ogni trasmissione
            N0=1/SNRF;
            noiseVariance=N0/2;

            symTx=A(randi(M),:); % simbolo trasmesso
            symRx=symTx+(sqrt(noiseVariance)*randn(1,size(A,2))); % simbolo ricevuto con rumore

            % Se questa trasmissione ha un SNR elevato, aggiorna il miglior simbolo ricevuto
            if SNRF > best_SNRF
                best_SNRF = SNRF;
                best_symRx = symRx; % simbolo con il miglior SNR
                best_symTx = symTx; % simbolo trasmesso associato
            end
        end

        % Decisione a minima distanza
        min_diff=Inf;
        symsceltoRx = []; % Simbolo scelto tramite decisione a minima distanza
        for kk=1:M %decisore a minima distanza
            curr_diff=norm(best_symRx-A(kk,:)); % calcolo della distanza tra simboli
            if curr_diff<min_diff
                min_diff=curr_diff;
                symsceltoRx=A(kk,:); % simbolo scelto al kk-esimo evento di trasmissione
            end
        end

        % Verifica degli errori
        if ~isequal(symsceltoRx, best_symTx)
            numErrori=numErrori+1;
        end

    end
    meanPe(ii)=numErrori/Montecarlo;
end

end