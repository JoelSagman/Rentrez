# Loading rentrez package script

ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1") #creates a string of ids that correspond with ncbi_ids
library(rentrez)  #loads rentrez package, which allows for interacting with genbank
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta") # downloads fasta files of specified ids from the nuccore database

Sequences<-strsplit(Bburg, "\n\n")

Sequences<-unlist(Sequences)

header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
Sequences<-data.frame(Name=header,Sequence=seq)

seq2<-gsub("\n", "", Sequences$Sequence)
Sequences<-data.frame(Name=header,Sequence=seq2)


write.csv(Sequences, "./Sequence Data/Sequences.csv", row.names=F)
