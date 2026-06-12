process ANNOTATE_MITOZ {

    tag "${fasta.baseName}"

    container "guanliangmeng/mitoz:3.6"

    publishDir "results/mitoz", mode: 'copy'

    input:
    path fasta

    output:
    path "${fasta.baseName}_mitoz_results"

    script:
    """
    mitoz annotate \
        --fastafiles ${fasta} \
        --outprefix ${fasta.baseName} \
        --clade Arthropoda \
        --workdir ./

    mkdir -p ${fasta.baseName}_mitoz_results
    mv ${fasta.baseName}.${fasta.getName()}.result/* ${fasta.baseName}_mitoz_results/
    """
}