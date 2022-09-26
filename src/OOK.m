function [OOK_Opt , Unideal_OOK, OOK_Theory] = OOK( N , Data , Eb_N0_dB , M )
%% Transmitter
Eb_N0 = 2 * 10 .^ ( Eb_N0_dB ./ 10 )' ;
S = zeros(1,length(Data)) ;
Data_Sq = zeros( 1, N*M ) ;
N0 = 2 ;

for i = 1 : length(Data)
    if Data(i) == 1
        S(i) = 1 ;
    elseif Data(i) == 0
        S(i) = 0 ;
    end
end
for i = 1 : N % Generating Rectangular Pulse From Binary Inputs
    Data_Sq(((i-1)*M)+1 : i*M  ) = S(i) ; 
end
figure(3);
pwelch(Data_Sq) ;
title("Welch Power Spectral Density Estimate For OOK Modulation") ;

%% Adding Channel Noise ( Gaussian Noise with Variance = 1 ) 
Noise = randn(1 , length(Data_Sq)) + 1i *randn(1 , length(Data_Sq)) ;
% Received Signal Affected By The Channel Noise
Received_Sig = sqrt(N0*Eb_N0 ./ (M) ) * Data_Sq + Noise ; 
scatterplot(Received_Sig(131,:)) ;
xlabel("Real") ;
ylabel("Imaginary") ;
title("Constellation Diagram For OOK Mod.(Eb/N0 = 13 dB)") ;

%% Demodulation
h = ones(1,M) ./ M ; % Moving Average Filter with Length = 10
y = zeros(size(Received_Sig,1) , size(Received_Sig,2) + M - 1 ) ;

for counter = 1 : size(Received_Sig,1)
    y(counter,:) = conv(Received_Sig(counter,:) , h) ;
end

%% Ideal Decision Making
Temp = zeros(size(Received_Sig,1) , N) ;
for row = 1 : size(Received_Sig, 1)
    for column = 1 : N
        Temp(row,column) = y(row , column*M) ;
    end
end
y_normalized = zeros(size(Eb_N0,1) , size(Temp,2) ) ;

for row = 1 : size(Eb_N0,1)
    for i = 1 : size(Temp,2)
        if real( Temp(row , i) ) > ( sqrt(N0*Eb_N0(row) ./ (1*M) ) / 2 )
            y_normalized(row ,i) = 1 ;
        else
            y_normalized(row , i) = 0 ;
        end
    end
end

Output = y_normalized ;
Pe = zeros(size(Received_Sig , 1) , 1 ) ;
for row = 1 : size(Eb_N0 , 1)
    for column = 1 : N
        if Output(row , column) ~= Data(column)
            Pe(row) = Pe(row) + 1 ;
        end
    end
end
OOK_Opt = Pe' / N ;
OOK_Theory = qfunc(sqrt(Eb_N0/2)) ;

%% Unideal Decision Making
Unideal_Temp = zeros(size(Received_Sig,1) , N) ;
for row = 1 : size(Received_Sig, 1)
    for column = 1 : N
        Unideal_Temp(row,column) = y(row , (column*M)-1 ) ;  % Adding Sampling Ofset
    end
end
Unideal_y_normalized = zeros(size(Eb_N0,1) , size(Unideal_Temp,2) ) ;

for row = 1 : size(Eb_N0,1)
    for i = 1 : size(Unideal_Temp,2)
        if real( Unideal_Temp(row , i) ) > ( sqrt(N0*Eb_N0(row) ./ (1*M) ) / 2 )
            Unideal_y_normalized(row ,i) = 1 ;
        else
            Unideal_y_normalized(row , i) = 0 ;
        end
    end
end

Unideal_Output = Unideal_y_normalized ;
Unideal_Pe = zeros(size(Received_Sig , 1) , 1 ) ;
for row = 1 : size(Eb_N0 , 1)
    for column = 1 : N
        if Unideal_Output(row , column) ~= Data(column)
            Unideal_Pe(row) = Unideal_Pe(row) + 1 ;
        end
    end
end
Unideal_OOK = Unideal_Pe' / N ;

end