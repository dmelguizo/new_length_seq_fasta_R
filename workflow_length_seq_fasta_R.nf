process lengthSeq {
	input:
	tuple val(id), val(seqString)

	script:
	"""
	#!/usr/bin/env Rscript
	paste("Length fasta sequence ID $id = ",nchar("$seqString"))
	"""
}

workflow {
	fastaChannel=Channel.fromPath("data/*.fa") | splitFasta(record: [id: true, seqString: true ])
	lengthSeq(fastaChannel)
}
