@echo off
hg pull -u
:: pre-sort
perl sorter2.pl liste_fr_2.txt
:: Add checksum
perl addChecksum.pl liste_fr_2.txt
:: Commit
hg commit -m "%*"
hg push