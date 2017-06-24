#!/bin/bash
# egrep -e "(is|are|am)\s[Aa]\s([A-Za-z]+-)?soldier" ReprocessedSimpleText/*
# egrep -e "\b(is|are|am)\s([A-Za-z]+-)?soldier" ReprocessedSimpleText/*

# singular assertions
# not "it", "is" or "am", optional "a", "soldier"
pcregrep -i -M "(?<!it)[\s,()]+(is|am)([\s,()]+a)?[\s,()]+([a-z]+-)?(bachelor|gentleman)\b" $1/*
# "are", optional "no" or "not", optional "a", "soldier"
pcregrep -i -M "\b(are)[\s,()]([\s,()]+not?)?([\s,()]+a)?[\s,()]+([a-z]+-)?(bachelor|gentleman)\b" $1/*
# "be", optional "no" or "not", optional "a", "soldier" 
pcregrep -i -M "\b(be)[\s,()]([\s,()]+not?)?([\s,()]+a)?[\s,()]+([a-z]+-)?(bachelor|gentleman)\b" $1/*
