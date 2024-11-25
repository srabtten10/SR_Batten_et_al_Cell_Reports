# PURPOSE OF CODE 

#Batten et al. (2025) 

#Emotional words evoke region and valence-specific patterns of concurrent neuromodulator release in human thalamus and cortex

#To take animal in vivo data and run LME with optogenetic
#stimulation for dopamine figure S1H-S1K

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

#-----------------------------Reading the Data-----------------------------
# Get the current working directory
getwd()

# List files in the current working directory
list.files()

# Set the correct working directory (replace with the correct path)
setwd("")

# Read the data file
dat_NT_DA <- read_excel("emostroop_rodent_LME_AUC_power_DA.xlsx", na = "N/A")

# removing spaces in column headers
names(dat_NT_DA) <- gsub(" ", "", names(dat_NT_DA))

#-----------------------------DA-type-----------------------------
dat_NT_DA$Power <- factor(dat_NT_DA$Power, levels = c(5, 10, 15))

##specifty that DA is the reference for the intercept
fit_LME_DA <- lmer(Measurement ~ Power + (1 | SubjectID), data = dat_NT_DA)
summary(fit_LME_DA)

anova(fit_LME_DA)
#-----------------------------NE-power-----------------------------
dat_NT_NE <- read_excel("emostroop_rodent_LME_AUC_power_NE.xlsx", na = "N/A")

# removing spaces in column headers
names(dat_NT_NE) <- gsub(" ", "", names(dat_NT_NE))

dat_NT_NE$Power <- factor(dat_NT_NE$Power, levels = c(5, 10, 15))

##specifty that DA is the reference for the intercept
fit_LME_NE <- lmer(Measurement ~ Power + (1 | SubjectID), data = dat_NT_NE)
summary(fit_LME_NE)

anova(fit_LME_NE)

#-----------------------------5HT-power-----------------------------
dat_NT_5HT <- read_excel("emostroop_rodent_LME_AUC_power_5HT.xlsx", na = "N/A")

# removing spaces in column headers
names(dat_NT_5HT) <- gsub(" ", "", names(dat_NT_5HT))

dat_NT_5HT$Power <- factor(dat_NT_5HT$Power, levels = c(5, 10, 15))

##specifty that DA is the reference for the intercept
fit_LME_5HT <- lmer(Measurement ~ Power + (1 | SubjectID), data = dat_NT_5HT)
summary(fit_LME_5HT)

anova(fit_LME_5HT)
