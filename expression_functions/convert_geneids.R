convert_geneids=function(genelist,
  from=c("entrezID","ENSEMBL","SYMBOL"),
  to=c("ENSEMBL","EntrezID","SYMBOL")){

  suppressMessages(symbols <- AnnotationDbi::mapIds(org.Hs.eg.db::org.Hs.eg.db, keys = genelist, keytype = from, column=to))

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
