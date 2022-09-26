# Bit Error Rate Performance Evaluation of BPSK & OOK & Binary Orthogonal Modulation in AWGN Channel in Matlab

## Initial setup

```matlab
N = 1e5 ; % Number Of Bits
Data = randi( 2 , [1 , N] ) - 1 ; % Generating Binary Bits Randomly For Input Data
Eb_N0_dB = 0 : 0.1 : 13 ;  
M = 10 ; % Sample Per Symbol (SPS)
```

# Results

---

## BPSK Modulation Results

<p align="center">
  <img src="/images/BPSK_PSD.png" />
</p>

<p align="center">
  <img src="/images/BPSK_Constellation.png" />
</p>

<p align="center">
  <img src="/images/BPSK_BER.png"/>
</p>

---

---
## OOK Modulation Results

<p align="center">
  <img src="/images/OOK_PSD.png" />
</p>

<p align="center">
  <img src="/images/OOK_Constellation.png" />
</p>

<p align="center">
  <img src="/images/OOK_BER.png"/>
</p>

---

---
## Binary Orthogonal Modulation Results

<p align="center">
  <img src="/images/BO_PSD.png" />
</p>

<p align="center">
  <img src="/images/BO_Constellation.png" />
</p>

<p align="center">
  <img src="/images/BO_BER.png"/>
</p>

---
## BER Comparison of all Modulations

<p align="center">
  <img src="/images/Totall_BER.png"/>
</p>





