# Bit Error Rate Performance of BPSK & OOK & Binary Orthogonal Modulation in AWGN Channel in Matlab

## Initial setup

```matlab
N = 1e5 ; % Number Of Bits
Data = randi( 2 , [1 , N] ) - 1 ; % Generating Binary Bits Randomly For Input Data
Eb_N0_dB = 0 : 0.1 : 13 ;  
M = 10 ; % Sample Per Symbol (SPS)
```

---
## BPSK Modulation Results
![BPSK PSD](/images/BPSK_PSD.png)

![BPSK Constellation](/images/BPSK_Constellation.png)

![BPSK BER](/images/BPSK_BER.png)

---

---
## OOK Modulation Results
![OOK PSD](/images/OOK_PSD.png)

![OOK Constellation](/images/OOK_Constellation.png)

![OOK BER](/images/OOK_BER.png)

---

---
## Binary Orthogonal Modulation Results
![BO PSD](/images/BO_PSD.png)

![BO Constellation](/images/BO_Constellation.png)

![BO BER](/images/BO_BER.png)

---
## BER Comparison of all Modulations

![BER](/images/Totall_BER.png)





