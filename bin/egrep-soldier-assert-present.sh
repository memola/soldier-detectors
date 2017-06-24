#!/bin/bash
# egrep -e "(is|are|am)\s[Aa]\s([A-Za-z]+-)?soldier" ReprocessedSimpleText/*
# egrep -e "\b(is|are|am)\s([A-Za-z]+-)?soldier" ReprocessedSimpleText/*

# singular assertions
# not "it", "is" or "am", optional "a", optionally prefixed "soldier""soldier"
pcregrep -i -M "(?<!it)[\W]+(is|am)([\s,()]+not?)?([\s,()]+a)?[\s,()]+([a-z]+-)?soldier[s-]?\b" $1/*

# "are", optional "no" or "not", optional "a", optionally prefixed "soldier"
pcregrep -i -M "\b(ar[et])([\s,()]+not?)?([\s,()]+a)?[\s,()]+([a-z]+-)?soldier[s-]?\b" $1/*

# "be", optional "no" or "not", optional "a", "soldier" 
pcregrep -i -M "\b(be)([\s,()]+not?)?([\s,()]+a)?[\s,()]+([a-z]+-)?soldier[s-]?\b" $1/*

# implied verb, optional "no" or "not", some word,  optional "a", optionally prefixed "soldier" 
#pcregrep -i -M "\b(I|you|s?he|thou|[w|y]e|they)([\s,()]+[a-zA-Z\-]+)?([\s,()]+not?)?([\s,()]+a?)?[\s,()]+soldier[s-]?\b" $1/*

# implied verb, optional "no" or "not",  optional "a", optionally prefixed "soldier" 
pcregrep -i -M "\b(I|you|s?he|thou|[w|y]e|they)([\s,()]+not?)?([\s,()]+a?)?[\s,()]+([a-z]+-)?soldier[s-]?\b" $1/*

# seeming
pcregrep -i -M "\bseems?([\s,()]+not?)?([\s,()]+a?)?[\s,()]+soldiers?\b" $1/*
pcregrep -i -M "soldiers?([\s,()]+(I|you|thou|[w|y]e|they))[\s,()]+seem" $1/*

# plural
# "are", optional "no" or "not", (0-1 words), "soldiers"
pcregrep -i -M "\b(are)([\s,()]+not?)?[\s,()]+([a-z]+-)?soldier[s-]?\b" $1/*

# two states
pcregrep -i -M "I[\s,()]+(am)([\s,()]+an?)?[\s,()]+\w+([A-z]+[\s,()]+){0,5}a\ssoldier[s-]?\b" $1/*

# contractions
pcregrep -i -M "I[\s]*'?me?([\s,()]+a?)?[\s,()]+soldiers?\b" $1/*
pcregrep -i -M "s?he[\s]*'?s([\s,()]+a?)?[\s,()]+soldiers?\b" $1/*
pcregrep -i -M "thou[\s]*'?rt([\s,()]+a?)?[\s,()]+soldiers?\b" $1/*
pcregrep -i -M "th[\s]*'?art([\s,()]+a?)?[\s,()]+soldiers?\b" $1/*
pcregrep -i -M "they[\s]*'?re?([\s,()]+a?)?[\s,()]+soldiers?\b" $1/*
pcregrep -i -M "you[\s]*'re?([\s,()]+a?)?[\s,()]+soldiers?\b" $1/*
pcregrep -i -M "youre?([\s,()]+a)[\s,()]+soldiers?\b" $1/*