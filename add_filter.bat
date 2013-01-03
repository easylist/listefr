@echo off
hg pull -u
:: pre-sort
python.exe FOP.py
:: Add checksum
perl addChecksum.pl liste_fr_2.txt
:: Commit
hg commit -m "%*"
hg push