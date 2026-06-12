nextflow.enable.dsl=2

include { DOWNLOAD_SEQUENCES } from './modules/download'
include { ANNOTATE_AGUS }      from './modules/annotate_agus'
include { ANNOTATE_MITOZ }     from './modules/annotate_mitoz'
include { SUMMARISE }          from './modules/summarise'

workflow {
    downloaded_fasta = Channel.fromPath("results/ixodidae_mtdna.fasta")

    fasta_sequences = downloaded_fasta
        .splitFasta(by: 1, file: true)

    if (params.tool == 'augustus') {
        annotated = ANNOTATE_AGUS(fasta_sequences)
    } else if (params.tool == 'mitoz') {
        annotated = ANNOTATE_MITOZ(fasta_sequences)
    } else {
        error "Please specify a tool: --tool augustus or --tool mitoz"
    }

    SUMMARISE(annotated.collect())
}