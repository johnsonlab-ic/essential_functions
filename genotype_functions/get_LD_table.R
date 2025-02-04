get_LD_table=function(SNP,r2){
    
    LD_table=ensemblQueryR::ensemblQueryLDwithSNPwindow(rsid= SNP, 
                      r2= r2, 
                      d.prime=0.0, 
                      window.size=500, 
                      pop="1000GENOMES:phase_3:EUR")
    LD_table=LD_table[complete.cases(LD_table),]
    LD_table=data.frame(rsid=c(SNP,LD_table$snp_in_ld),r2=c("1.000000",LD_table$r2))
    LD_table=LD_table[complete.cases(LD_table),]
    return(LD_table)
}
