#!/bin/bash

set -e

echo -e "\n---------------------------------------------------------------"
echo -e "\t\tLEGEND FILE CREATOR"
echo -e "\nUsage:"
echo -e "\t./legend-file-creator file_name"
echo -e "\n\nThe file_name is a frequency file output from VCFTOOLS --freq"
echo -e "\nOptionally population name can be provided:"
echo -e "\t./legend-file-creator file_name pop_name"
echo -e "-----------------------------------------------------------------\n\n"

INPUT_FILE_NAME=${1?Error: no file name given}

POP_NAME=${2:-POP}

if [ $POP_NAME == 'POP' ]
then
	echo "...No population name given."
	echo -e "...Naming population "POP".\n\n"
fi

echo -e "Creating LEGEND file for population ${POP_NAME}...\n"
awk 'NR>1 {gsub(":","\t");print}' ${INPUT_FILE_NAME} > tmp1.freq

echo "...Parsing variants..."
awk -v OFS="\t" '{if(length($9) && (length($5)>1 || length($7) > 1 || length($9) > 1)) $3="Multiallelic_INDEL"; else if(length($9)) $3="Multiallelic_SNP"; else if(length($5)>1 || length($7) > 1) $3="Biallelic_INDEL"; else $3="Biallelic_SNP";print $0}' tmp1.freq > tmp2.freq

awk -v OFS="\t" '$9 != "" {print;$5=$7;$6=$8;$7=$9;$8=$10;$9="";$10="";print;next}1' tmp2.freq > tmp3.freq

echo "...Dividing multiallelic variants into biallelic pairs..."
awk -v OFS="\t" '{print $1 ":" $2 ":" $5 ":" $7 "\t" $1 "\t" $2 "\t" $5 "\t" $7 "\t" $3 "\t" $8}' tmp3.freq > tmp4.freq

echo "...Creating header..."
echo -e "id\tchr\tposition\ta0\ta1\tTYPE\t${POP_NAME}" > tmp.header
cat tmp.header tmp4.freq > ${POP_NAME}.legend

rm tmp*

echo -e "\nDone!"

