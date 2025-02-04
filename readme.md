# Essential Functions

This repository contains a collection of essential functions for gene expression and genotype analysis. Each function is stored in its own script file for modularity and ease of use.

## Functions

### Gene Expression Related Functions

- **convert_geneids**: Converts gene identifiers between different formats.
  - File: `expression_functions/convert_geneids.R`
  - Usage: `convert_geneids(genelist, format, conversion)`

- **get_gene_locations**: Retrieves the genomic locations of specified genes.
  - File: `expression_functions/get_gene_locations.R`
  - Usage: `get_gene_locations(genes, build)`

### Genotype Related Functions

- **get_SNP_position**: Retrieves the genomic positions of specified SNPs.
  - File: `genotype_functions/get_SNP_position.R`
  - Usage: `get_SNP_position(snp_vector, build)`

- **chrpos_to_rsid**: Converts chromosome positions to rsIDs.
  - File: `genotype_functions/chrpos_to_rsid.R`
  - Usage: `chrpos_to_rsid(chromlocs, build)`

- **get_LD_table**: Retrieves the linkage disequilibrium table for a specified SNP.
  - File: `genotype_functions/get_LD_table.R`
  - Usage: `get_LD_table(SNP, r2)`

## Installation

To use these functions, you need to have R installed along with the required packages. You can install the necessary packages using the following commands:

```r
install.packages(c("AnnotationDbi", "BSgenome", "GenomicFeatures", "GenomicRanges", "dplyr", "ensemblQueryR"))
BiocManager::install(c("org.Hs.eg.db", "TxDb.Hsapiens.UCSC.hg19.knownGene", "TxDb.Hsapiens.UCSC.hg38.knownGene", "SNPlocs.Hsapiens.dbSNP144.GRCh37", "SNPlocs.Hsapiens.dbSNP151.GRCh38", "SNPlocs.Hsapiens.dbSNP155.GRCh37", "SNPlocs.Hsapiens.dbSNP155.GRCh38"))
```

## Usage

You can source the individual function scripts in your R environment and call the functions as needed. For example:

```r
source("path/to/expression_functions/convert_geneids.R")
source("path/to/genotype_functions/get_SNP_position.R")

# Example usage
genelist <- c("BRCA1", "TP53")
converted_genes <- convert_geneids(genelist, format="SYMBOL", conversion="ENSEMBL")

snp_vector <- c("rs123", "rs456")
snp_positions <- get_SNP_position(snp_vector, build="hg19")
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.