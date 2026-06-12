process DOWNLOAD_SEQUENCES {
    publishDir "results", mode: 'copy'
    output:
    path "ixodidae_mtdna.fasta"
    script:
    def query = 'Ixodidae[Organism] AND mitochondrion[Title] AND "complete genome"'
    """
    export PATH=/Users/fatimadiaz/miniforge3/envs/genome_annotation_ixodes/bin:\$PATH
    esearch -db nucleotide \
        -query '${query}' \
    | efetch -format fasta \
    | awk '
        /^>/ {
            count++
            if (count > 20) exit
        }
        { print }
    ' > ixodidae_mtdna.fasta
    """
}