%%
% Codice per l'elaborazione di due grafici che mostrino l'andamento della
% Probabilità di errore di simbolo media, al variare di SNR, quando si
% sceglie
% come tecnica di modulazione il PAM;
% Primo Plot:
%   - Probabilità di errore di simbolo media simulata con e senza fading
%   - Probabilità di errore di simbolo media teorica

% Secondo Plot:
%   - Probabilità di errore di simbolo media simulata con fading, con e
%     senza tecnica di diversità nel tempo
%   - Probabilità di errore di simbolo media teorica
%

function []=graphicInterfacePAM(A,SNRdB,Pe,PeFading,PeDiveristy);
    SNR=10.^(SNRdB/10);
    M=size(A,1);
    figure;
    
    %primo plot
    subplot(2,1,1);
    semilogy(SNRdB, 2*((M-1)/M)*qfunc(sqrt(6/(M^2-1)*SNR)), 'k-', 'LineWidth', 2, 'DisplayName', 'Pe Teorica');
    hold on;
    semilogy(SNRdB, PeFading, 'b--.','MarkerSize', 30, 'DisplayName', 'Pe Simulata - Fading');
    semilogy(SNRdB, Pe, 'r--.', 'MarkerSize', 30, 'DisplayName', 'Pe Simulata - non Fading');
    hold off;
    xlabel('SNR (dB)','FontSize',15);
    ylabel('Pe','FontSize',15);
    title('PAM: Confronto Pe simulata - fading - non fading','FontSize',15);
    leg=legend('show');
    leg.FontSize=15;
    grid on;

    %secondo plot
    subplot(2,1,2);
    semilogy(SNRdB, 2*((M-1)/M)*qfunc(sqrt(6/(M^2-1)*SNR)), 'k-', 'LineWidth', 2, 'DisplayName', 'Pe Teorica');
    hold on;
    semilogy(SNRdB, PeFading, 'b--.','MarkerSize', 30, 'DisplayName', 'Pe Simulata - Fading');
    semilogy(SNRdB, PeDiveristy, 'r--.', 'MarkerSize', 30, 'DisplayName', 'Pe Simulata - Diversity')
    hold off;
    xlabel('SNR (dB)','FontSize',15);
    ylabel('Pe','FontSize',15);
    title('PAM: Confronto Pe simulata - fading - diversità','FontSize',15);
    leg=legend('show');
    leg.FontSize=15;
    grid on;
end