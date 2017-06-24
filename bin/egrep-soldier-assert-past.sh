#!/bin/bash
pcregrep -i -M "\b(was|were)([\s,()]+not?)?([\s,()]+(a|thier|my|y?our))?[\s,()]+([a-z]+-)?soldiers?\b" $1/*
pcregrep -i -M "\b(ha(ve|s)\s(not\s)?b(ee|i)n)[\s,()]([\s,()]+not?)?([\s,()]+(a|thier|my|y?our))?[\s,()]+([a-z]+-)?soldiers?\b" $1/*
