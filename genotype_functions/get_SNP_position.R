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
