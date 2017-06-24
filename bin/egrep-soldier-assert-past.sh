#!/bin/bash
pcregrep -i -M "\b(was|were)([\s,()]+not?)?([\s,()]+a)?[\s,()]+([a-z]+-)?soldier\b" $1/*
pcregrep -i -M "\b(ha(ve|s)\s(not\s)?been)[\s,()]([\s,()]+not?)?([\s,()]+a)?[\s,()]+([a-z]+-)?soldier\b" $1/*
