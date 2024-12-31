%%
% Codice per l'elaborazione di due grafici che mostrino l'andamento della
% Probabilità di errore di simbolo media, al variare di SNR, quando si
% sceglie
% come tecnica di modulazione il PPM;
% Primo Plot:
%   - Probabilità di errore di simbolo media simulata con e senza fading
%   - Probabilità di errore di simbolo media teorica

% Secondo Plot:
%   - Probabilità di errore di simbolo media simulata con fading, con e
%     senza tecnica di diversità nel tempo
%   - Probabilità di errore di simbolo media teorica
%

function []=graphicInterfacePPM(A,SNRdB,Pe,PeFading,PeDiversity);
    SNR=10.^(SNRdB/10);
    M=size(A,1);
    figure;

    %primo plot
    subplot(2,1,1);
    semilogy(SNRdB, (M-1/M)*qfunc(sqrt(SNR)), 'k-', 'LineWidth', 2.5, 'DisplayName', 'Pe Teorica');
    hold on;
    semilogy(SNRdB, PeFading, 'b--.', 'MarkerSize', 30, 'DisplayName', 'Pe Simulata - Fading');
    semilogy(SNRdB, Pe, 'r--.', 'MarkerSize', 30, 'DisplayName', 'Pe Simulata - non Fading');
    hold off;
    xlabel('SNR (dB)');
    ylabel('Pe');
    title('PPM: Confronto Pe simulata - fading - non fading','FontSize',15);
    leg=legend('show');
    leg.FontSize=15;
    grid on;

    %secondo plot
    subplot(2,1,2);
    semilogy(SNRdB, (M-1/M)*qfunc(sqrt(SNR)), 'k-', 'LineWidth', 2.5, 'DisplayName', 'Pe Teorica');
    hold on;
    semilogy(SNRdB, PeFading, 'b--.', 'MarkerSize', 30, 'DisplayName', 'Pe Simulata - Fading');
    semilogy(SNRdB, PeDiversity, 'r--.', 'MarkerSize', 30, 'DisplayName', 'Pe Simulata - Diversity');
    hold off;
    xlabel('SNR (dB)');
    ylabel('Pe');
    title('PPM: Confronto Pe simulata - fading - diversità','FontSize',15);
    leg=legend('show');
    leg.FontSize=15;
    grid on;
end

