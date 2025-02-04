get_gene_locations=function(genes,build="hg38"){

  yourgenes<-as.character(genes)

  if(build=="hg19"){
    ucsc_genes<-TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene
  }else{
    ucsc_genes<-TxDb.Hsapiens.UCSC.hg38.knownGene::TxDb.Hsapiens.UCSC.hg38.knownGene
  }
  allgenes<-as.data.frame(org.Hs.eg.db::org.Hs.egSYMBOL)

  ## get ucsc sequences
  allgranges<-suppressMessages(GenomicFeatures::genes(ucsc_genes,single.strand.genes.only=FALSE,columns="gene_id"))
  allgranges<-unlist(allgranges)
  gene_ids<-names(allgranges)
  allgranges<-data.frame(allgranges)
  allgranges$gene_id<-gene_ids

  ##remove random sequences
  toremove<-c("alt","fix","random")
  seqnames_toremove<-c(grep(paste(toremove,collapse = "|"),allgranges$seqnames))
  allgranges<-allgranges[-seqnames_toremove,]

  ##filter symbol df
  commongenes<-intersect(allgenes$gene_id,allgranges$gene_id)
  allgenes<-allgenes[allgenes$gene_id %in% commongenes,]

  ##create final chrompos_mat
  allgenes$start<-allgranges$start[match(allgenes$gene_id,allgranges$gene_id)]
  allgenes$end<-allgranges$end[match(allgenes$gene_id,allgranges$gene_id)]
  allgenes$chr<-allgranges$seqnames[match(allgenes$gene_id,allgranges$gene_id)]

  ##filter for the genes we have
  allgenes<-allgenes[allgenes$symbol %in% yourgenes,]

  ##reorganize and return
  allgenes<-allgenes[,c("symbol","chr","start","end")]
  colnames(allgenes)<-c("geneid","chr","left","right")
  return(allgenes)
}
