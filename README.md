# Phosphoglycerylation

This repository contains test and train data for building PhoglyStruct predictor. The performance metrics on the provided train and test data can be obtained by running the PhoglyStruct.m script

The data comprises protein sequence name, feature vector, label (whether phosphoglycerylated for not) and the location of lysine in the protein sequence.
Feature vector is of 56 dimension pertaining to accessible surface area, amino acid contribution to local structure conformations and backbone torsion angles of three amino acids downstream and upstream of lysine and lysine itself.

Make sure to extract the libsvm-weights-3.22 file before running the PhoglyStruct.m script

