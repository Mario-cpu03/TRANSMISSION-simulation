%%
% buildconstellation permette di costruire una qualsiasi costellazione di
% simboli a patto che essa faccia riferimento ad uno dei 4 metodi di
% modulazioni seguenti:
% - PAM
% - PPM
% - QAM
% - PSK

function A=buildconstellation(M,Model);

% INPUT
% M= numero di simboli;
% Model= nome del tipo di modulazione adottato ('PAM', 'PPM', 'QAM','PSK');

% OUTPUT
% A= matrice M*N dei simboli trasmissibili; 
switch Model
    case 'PAM'
        A=-(M-1):2:(M-1);
        A=A/sqrt(mean(A.^2));
        A=A(:);
    case 'PPM'
        A=diag(ones(1,M));
    case 'QAM'
        k=log2(M);
        if rem(k,2)==0
            M1=2^(k/2);
            [j,z] = meshgrid(-(M1-1):2:(M1-1));
            A=[j(:),z(:)];
            A=A/sqrt(mean(A(:,1).^2+A(:,2).^2));
        else   
            k2=floor(k/2);
            k1=k2+1;
            M1=2^(k1);
            M2=2^(k2);
            [j,z] = meshgrid(-(M1-1):2:(M1-1),-(M2-1):2:(M2-1));
            A=[j(:),z(:)];
            A=A/sqrt(mean(A(:,1).^2+A(:,2).^2));
        end
      case 'PSK'
        A=zeros(M,2);
        for i=1:M
            A(i,1:2)=[cos((i-1)*(2*pi)/M),sin((i-1)*(2*pi)/M)];
        end
end
end