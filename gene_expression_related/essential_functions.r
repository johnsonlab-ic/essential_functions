library(org.Hs.eg.db)

convert_geneids=function(genelist,
  format=c("entrezID","ENSEMBL","SYMBOL"),
  conversion=c("ENSEMBL","EntrezID","SYMBOL")){


  suppressMessages(symbols <- mapIds(org.Hs.eg.db, keys = genelist, keytype = format, column=conversion))

  symbols<-as.data.frame(symbols)
  symbols$pre_conversion<-rownames(symbols)
  genesbefore<-nrow(symbols)
  # symbols<-symbols[complete.cases(symbols),]

  genesafter<-genesbefore-nrow(symbols)

  if(genesafter>0 ){
    message(paste0(genesafter," genes were lost/didn't match Ensembl IDs. Double-check gene names!"))
    return(symbols)
  } else {
    return(symbols$symbols)
  }


}

get_SNP_position=function(snp_vector,build="hg19"){


    if(build=="hg19"){

        snp<-SNPlocs.Hsapiens.dbSNP155.GRCh37::SNPlocs.Hsapiens.dbSNP155.GRCh37

    } else if(build=="hg38"){

        check_version=grep("155",system.file(package="SNPlocs.Hsapiens.dbSNP155.GRCh38"))
        if(length(check_version)==1){
        snp<-SNPlocs.Hsapiens.dbSNP155.GRCh38::SNPlocs.Hsapiens.dbSNP155.GRCh38
        }else{
        snp<-SNPlocs.Hsapiens.dbSNP151.GRCh38::SNPlocs.Hsapiens.dbSNP151.GRCh38
        }

    }

    gr=BSgenome::snpsById(snp,snp_vector,ifnotfound="drop")
    gr=as.data.frame(gr)
    return(gr)

}

get_gene_locations=function(genes,build="hg38"){

  yourgenes<-as.character(genes)


  # Create df and granges of all genes. These differ actually



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
