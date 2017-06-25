#!/bin/bash
pcregrep -i -M "\b(was|were)([\s,()]+not?)?([\s,()]+a)?[\s,()]+([a-z]+-)?soldiers?\b" $1/*
# have [not] I been [not]
pcregrep -i -M "\b(ha(ve|d|s|th))([\s,()]+not?)?([\s,()]+(I|(th|y)ou|we|s?he|they))?[\s,()]+b(ee?|i)n([\s,()]+not?)?([\s,()]+a)?[\s,()]+([a-z]+-)?soldiers?\b" $1/*
# have I [not] been [not]
pcregrep -i -M "\b(ha(ve|d|s|th))([\s,()]+(I|(th|y)ou|we|s?he|they))?([\s,()]+not?)?[\s,()]+b(ee?|i)n([\s,()]+not?)?([\s,()]+a)?[\s,()]+([a-z]+-)?soldiers?\b" $1/*
# have [not] been [not]
pcregrep -i -M "\b(ha(ve|d|s|th))([\s,()]+not?)?[\s,()]+b(ee?|i)n([\s,()]+not?)?([\s,()]+a)?[\s,()]+([a-z]+-)?soldiers?\b" $1/*
