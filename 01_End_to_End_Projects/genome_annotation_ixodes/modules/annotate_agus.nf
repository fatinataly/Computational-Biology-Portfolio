process ANNOTATE_AGUS {

    tag "${fasta.baseName}"

    publishDir "results/gff", mode: 'copy'

    input:
    path fasta

    output:
    path "${fasta.baseName}.gff"


    script:
    """
    sed 's/ .*//' ${fasta} > clean.fasta
    augustus \
        --species=pea_aphid \
        --gff3=on \
        clean.fasta \
        > ${fasta.baseName}.gff
    """
}