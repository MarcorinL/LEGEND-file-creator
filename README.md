# LEGEND-file-creator
Creates LEGEND file to run with HRC-1000G-check-bim from the McCarthy Group Tools

The McCarthy group developed the HRC-1000G-check-bim tool to prepare VCF files for imputation
in the Sanger Imputation Server. The group also provides LEGEND files for global and continental
populations from fhe 1000 Genomes Project and the Haplotype Reference Consortium.

Although, if you want to use a different population as reference for the VCF file preparation, a
new LEGEND file needs to be created. This script creates a LEGEND format file for a given population
using VCFTOOLS --freq output as input.

Please note that this script was not developed by the McCarthy group.
Use it at your own risk.

For more information on the LEGEND format file, HRC-1000G-check-bim software and citation,
please visit the McCarthy Group Tools website https://www.well.ox.ac.uk/~wrayner/tools/.

For more information on VCFTOOLS visit https://vcftools.github.io/.

------------------------------------------------------------------------------------------------------

Usage:
  ./LEGEND-file-creator file_name

Imput file_name must be a frequency file outputed from VCFTOOLS --freq argument.

Optionally, a population name can be provided:
  ./LEGEND-file-creator file_name pop_name

Output:
Single LEGEND file for all variants provided in the frequency file for the given population.
If pop_name is not given, the population will be named "POP" and the output file will be named POP.legend.

