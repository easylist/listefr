@echo off
hg pull -u
:: pre-sort
FOP.py
:: Add checksum
perl addChecksum.pl liste_fr_2.txt
:: Commit
hg commit -m "%*"
hg push