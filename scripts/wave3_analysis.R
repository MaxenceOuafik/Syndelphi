library(ConsRank)
source("./scripts/wave3_cleaning.R", encoding = "UTF-8")

set.seed(25)

cis_consrank <- consrank(wave3_cis_rang,
                         algorithm = "fast")

cis_rank_final <- as.data.frame(cis_consrank$Consensus[5, ])


trans_consrank <- consrank(wave3_trans_rang, 
                           algorithm = "fast")

trans_rank_final <- as.data.frame(trans_consrank$Consensus[2, ])

cis_consrank$Consensus
