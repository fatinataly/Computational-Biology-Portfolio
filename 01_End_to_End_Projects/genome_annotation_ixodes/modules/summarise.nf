process SUMMARISE {

    publishDir "results/summary", mode: 'copy'

    input:
    path gff_files

    output:
    path "annotation_summary.tsv"

    script:
    """
    echo -e "sequence_id\tgene_count" > annotation_summary.tsv

    for gff in ${gff_files}; do
        seq_id=\$(basename "\$gff" .gff)

        gene_count=\$(awk '\$3 == "gene" {count++} END {print count+0}' "\$gff")

        echo -e "\${seq_id}\t\${gene_count}" >> annotation_summary.tsv
    done
    """
}