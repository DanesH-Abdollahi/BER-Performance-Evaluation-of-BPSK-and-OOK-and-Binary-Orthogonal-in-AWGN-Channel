function [Orthogonal_Opt ,Unideal_Orthogonal,Orthogonal_Theory] = Binary_Orthogonal( N , Data , Eb_N0_dB , M ) 
%% Transmitter
Eb_N0 = 2 * 10 .^ ( Eb_N0_dB ./ 10 )' ;
S = zeros(1,length(Data)) ;
N0 = 2 ;

for i = 1 : length(Data)
    if Data(i) == 1
        S(i) = 1 ;
    elseif Data(i) == 0
        S(i) = 1i ;
    end
end
Data_Sq = zeros( 1, N*M ) ;
for i = 1 : N
    Data_Sq(((i-1)*M)+1 : i*M  ) = S(i) ;
end

Pulse = zeros( 1, N*M ) ;
for i = 1 : N % Generating Rectangular Pulse From Binary Inputs
    if S(i) == 1
        Pulse(((i-1)*M)+1 : i*M  ) = S(i) ;
    else
        Pulse(((i-1)*M)+1 : (i*M) - (M/2)  ) = 1 ;
        Pulse((i*M) - (M/2)+1 : i*M ) = -1 ;
    end
end
figure(5) ;
pwelch(Pulse) ;
title("Welch Power Spectral Density Estimate For Binary Orthogonal Modulation") ;

%% Adding Channel Noise ( Gaussian Noise with Variance = 1 ) 
Noise = randn(1 , length(Data_Sq)) + 1i * randn(1 , length(Data_Sq)) ;
% Received Signal Affected By The Channel Noise
Received_Sig = sqrt(N0*Eb_N0 ./(sqrt(2)* M)) * Data_Sq + Noise ;
scatterplot(Received_Sig(131,:)) ;
xlabel("Real") ;
ylabel("Imaginary") ;
title("Constellation Diagram For Binary Orthogonal Mod.(Eb/N0 = 13 dB)") ;

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
Output = zeros(size(Eb_N0,1) , size(y_normalized,2) ) ;

for row = 1 : size(Eb_N0,1)
    for i = 1 : size(Temp,2)
        if imag( Temp(row , i) ) >  real( Temp(row , i) )
            y_normalized(row ,i) = 1i ;
        else
            y_normalized(row , i) = 1 ;
        end
    end
end

for row = 1 : size(Eb_N0,1)
    for i = 1 : length(y_normalized)
        if y_normalized(row , i) == 1i
            Output(row ,i) = 0 ;
        elseif y_normalized(row , i) == 1
            Output(row , i) = 1 ;
        end
    end
end

Pe = zeros(size(Received_Sig , 1) , 1 ) ;
for row = 1 : size(Eb_N0 , 1)
    for column = 1 : N
        if Output(row , column) ~= Data(column)
            Pe(row) = Pe(row) + 1 ;
        end
    end
end
Orthogonal_Opt = Pe' / N ;
Orthogonal_Theory = qfunc(sqrt(Eb_N0/sqrt(2))) ;

%% Unideal Decision Making
Unideal_Temp = zeros(size(Received_Sig,1) , N) ;
for row = 1 : size(Received_Sig, 1)
    for column = 1 : N
        Unideal_Temp(row,column) = y(row , (column*M) -1 ) ; %  Adding Sampling Ofset
    end
end
Unideal_y_normalized = zeros(size(Eb_N0,1) , size(Unideal_Temp,2) ) ;
Unideal_Output = zeros(size(Eb_N0,1) , size(Unideal_y_normalized,2) ) ;

for row = 1 : size(Eb_N0,1)
    for i = 1 : size(Unideal_Temp,2)
        if imag( Unideal_Temp(row , i) ) >  real( Unideal_Temp(row , i) )
            Unideal_y_normalized(row ,i) = 1i ;
        else
            Unideal_y_normalized(row , i) = 1 ;
        end
    end
end

for row = 1 : size(Eb_N0,1)
    for i = 1 : length(Unideal_y_normalized)
        if Unideal_y_normalized(row , i) == 1i
            Unideal_Output(row ,i) = 0 ;
        elseif Unideal_y_normalized(row , i) == 1
            Unideal_Output(row , i) = 1 ;
        end
    end
end

Unideal_Pe = zeros(size(Received_Sig , 1) , 1 ) ;
for row = 1 : size(Eb_N0 , 1)
    for column = 1 : N
        if Unideal_Output(row , column) ~= Data(column)
            Unideal_Pe(row) = Unideal_Pe(row) + 1 ;
        end
    end
end
Unideal_Orthogonal = Unideal_Pe' / N ;

end