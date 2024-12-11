process gcSeq {
	input:
	tuple val(id), val(seq)

	script:
	"""
	#!/usr/bin/env Rscript
	gc<-gregexpr(pattern="[GC]",text ="$seq")
	percentage_GC<-(length(gc[[1]])/nchar("$seq")) * 100
	print(paste0("GC content fasta sequence ID $id = ", round(percentage_GC,2))) 
	"""
}
workflow {
	fastaChannel=Channel.fromPath("data/*.fa") | splitFasta(record: [id: true, seqString: true ])
	gcSeq(fastaChannel)
}

