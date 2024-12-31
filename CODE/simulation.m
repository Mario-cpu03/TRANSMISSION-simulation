%%
% Codice per la stima della probabilità media di errore di simbolo in un
% sistema di modulazione digitale mediante la simulazione di trasmissioni wireless 
% su canale affetto da rumore bianco AWGN e senza interferenze. 
% Il codice offre come parametro di valutazione delle prestazioni delle
% diverse fondamentali tecniche di modulazione la probabilità di errore
% media nelle seguenti quattro ipotesi:
% 1) Probabilità di errore teorica, nessuna simulazione di trasmissione;
% 2) Probabilità di errore simulata con i soli effetti del rumore;
% 3) Probabilità di errore simulata in presenza di rumore e  fading di
%    Rayleigh;
% 4) Probabilità di errore simulata in presenza di rumore e fading di Rayleigh ma,
%    con implementazione della tecnica di diversità nel tempo.

function []=simulation(M,SNRdB,Montecarlo,Model,L);

% INPUT
% M= numero di simboli che posso trasmettere; 
% SNRdB= intervallo di rapporto segnale rumore di interesse;
% MonteCarlo= numero di simulazioni di trasmissione; 
% Model= nome del tipo di modulazione adottato (PAM, PPM, QAM, PSK);
% L= numero di ritrasmissioni per singolo simbolo;

% OUTPUT
% Matrice dei simboli A= matrice M*N dei simboli trasmissibili; 

% OUTPUT GRAFICO
% Due grafici in un piano (SNRdB,Pe) che mostrano l'andamento della 
% Pe teorica, Pe simulata con e senza fading di Rayleigh e con tecnica di diversità nel tempo. 

%------------> Controllo parametri in input
restoM=mod(M,2);%restoM=0 -> condizione verificata
assert((restoM==0), 'Numero di simboli non multiplo di 2'); %numero di simboli multiplo di due

%------------> Parametri in input corretti, posso simulare
fprintf('\nParametri corretti\n');
fprintf('\n');
fprintf('***********************************\n');
fprintf('*** risultati della simulazione ***\n');
fprintf('***********************************\n');
fprintf('\n');

%------------> Costruzione della costellazione
A=buildconstellation(M,Model);
fprintf('Matrice dei simboli A =\n');
disp(A);
N=size(A,2);

%------------> Simulazione di Trasmissione
PeFading=simulaTransmissionFading(A,SNRdB,Montecarlo,M); %trasmissione con fading
Pe=simulaTransmissionNonfading(A,SNRdB,Montecarlo,M); %trasmissione senza fading
PeDiveristy=simulaTransmissionDiversity(A,SNRdB,Montecarlo,M,L); %trasmissione con tecnica di diversità nel tempo

%------------> Interfaccia grafica
switch Model
    case 'PAM'
        graphicInterfacePAM(A,SNRdB,Pe,PeFading,PeDiveristy);
    case 'PPM'
        graphicInterfacePPM(A,SNRdB,Pe,PeFading,PeDiveristy);
    case 'QAM'
        graphicInterfaceQAM(A,SNRdB,Pe,PeFading,PeDiveristy);
    case 'PSK'
        graphicInterfacePSK(A,SNRdB,Pe,PeFading,PeDiveristy);
end

end