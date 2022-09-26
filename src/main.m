% .........................................................................
% ****************  Communication II_Fall 2021_Dr.Emadi  ******************
% ******************************  HW-5  ***********************************
% ********************  DanesH Abdollahi - 9723053  ***********************
% .........................................................................
clc ; clear ; close all ;

%% Intitialization
N = 1e5 ; % Number Of Bits
Data = randi( 2 , [1 , N] ) - 1 ; % Generating Binary Bits Randomly For Input Data
Eb_N0_dB = 0 : 0.1 : 13 ;  
M = 10 ; % Sample Per Symbol (SPS)

%% BPSK
[BPSK_Opt ,Unideal_BPSK, BPSK_Theory] = BPSK( N , Data , Eb_N0_dB , M ) ;

%% OOK
[OOK_Opt , Unideal_OOK, OOK_Theory] = OOK( N , Data , Eb_N0_dB , M ) ;

%% Binary Orthogonal
[Orthogonal_Opt ,Unideal_Orthogonal,Orthogonal_Theory] = Binary_Orthogonal( N , Data , Eb_N0_dB , M ) ;

%% Plotting
figure(7) ;
% BPSk
semilogy(Eb_N0_dB ,BPSK_Opt , '-- r' ,'linewidth' , 1 ) ;
hold on ;
semilogy(Eb_N0_dB ,Unideal_BPSK , 'g','linewidth' , 1  ) ;
hold on ;
semilogy(Eb_N0_dB ,BPSK_Theory , '-. b','linewidth' , 1  ) ;
hold on ;
% OOK
semilogy(Eb_N0_dB ,OOK_Opt , '+ r','linewidth' , 1  ) ;
hold on ;
semilogy(Eb_N0_dB ,Unideal_OOK , 'x g','linewidth' , 1  ) ;
hold on ;
semilogy(Eb_N0_dB ,OOK_Theory , '* b','linewidth' , 1  ) ;
hold on ;
% % Binary Orthogonal
semilogy(Eb_N0_dB ,Orthogonal_Opt , 's r','linewidth' , 1   ) ;
hold on ;
semilogy(Eb_N0_dB ,Unideal_Orthogonal , 'o g','linewidth' , 1  ) ;
hold on ;
semilogy(Eb_N0_dB ,Orthogonal_Theory , 'd b','linewidth' , 1   ) ;
xlabel("Eb/N0 (dB)") ;
ylabel("Pe") ;
title("Bit Error Rate (BER)") ;
grid minor ;
legend( "Optimum BPSK","Unideal BPSK","Theory BPSK","Optimum OOK"...
    ,"Unideal OOK","Theory OOK","Optimum Orthogonal","Unideal Orthogonal"...
    ,"Theory Orthogonal",'Location','Southwest');
