# PURPOSE OF CODE 

#Batten et al. (2025) 

#Emotional words evoke region and valence-specific patterns of concurrent neuromodulator release in human thalamus and cortex

#To take animal in vivo data and run LME with optogenetic
#stimulation for dopamine figure S1R-S1U

#Alec Hartle and Seth R. Batten srbatten10@vtc.vt.edu 2024
#------------Clear environment------------

rm(list = ls())

#-----------------------------Loading the required packages (DOWNLOAD THEM FIRST) -----------------------------

library(readxl)
library(lme4)
library(lmerTest)
library(emmeans)
library(tidyverse)
library(pbkrtest)
library(ggplot2)
library(gridExtra)
library(MuMIn)

#Set the correct working directory (replace with the correct path)
setwd("")
# Read the data file
dat_NT <- read_excel("emostroop_rodent_LME_AUC_NTs_5HT.xlsx", na = "N/A")
dat_stim_null <- read_excel("emostroop_rodent_LME_AUC_stim_null_5HT.xlsx", na = "N/A")

# removing spaces in column headers

names(dat_NT) <- gsub(" ", "", names(dat_NT))
names(dat_stim_null) <- gsub(" ", "", names(dat_stim_null))

#-----------------------------NT-type-----------------------------
dat_NT$NeurotransmitterType <- factor(dat_NT$NeurotransmitterType)
##specifty that 5HT is the reference for the intercept
fit_LME_NT <- lmer(Measurement ~ 1 + NeurotransmitterType + (1 | SubjectID), data = dat_NT)
summary(fit_LME_NT)
anova(fit_LME_NT)
emmeans_results_NT <- emmeans(fit_LME_NT, ~ NeurotransmitterType)

# (Optional) Adjust for multiple comparisons
pairwise_comparisons_NT_adj <- pairs(emmeans_results_NT, adjust = "tukey")
print(pairwise_comparisons_NT_adj)

# 
#-----------------------------stim-null-----------------------------
dat_stim_null$LightType <- factor(dat_stim_null$LightType)

fit_LME_stim_null <- lmer(Measurement ~ 1 + LightType + (1 | SubjectID), data = dat_stim_null)
summary(fit_LME_stim_null)
