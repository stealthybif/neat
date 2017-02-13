#!/bin/bash

##############
# Written by Eric Kan
# 2/2/2017
# Use however you like
#
# Inputs:  	<subject number> - Subject ID
#			<idir> - input directory, parent directory of where subject dicom files are located
#			<odir> - output directory for NIFTI files to copied to
#
# Outputs:	On terminal: checklist of scans that pass filecount QC
#			In output directory: NIFTI converted image files
##############

#######
# MODIFY DIRECTORY contents below to reflect your scan names and expected number of dicom files
###############################
# Directory contents in Scan 1:
	#AAHScout
	##AAHScout_MPR_cor
	##AAHScout_MPR_sag
	##AAHScout_MPR_tra
	##BIAS_32CH
	fmri_foodcues=440
	fmri_foodcues_SBRef=1
	FOOD_SpinEchoFieldMap_AP=3
	FOOD_SpinEchoFieldMap_PA=3
	##Localizer
	##Localizer_aligned
	MB_Axial_DTI_AP_110_b2500=111
	##MB_Axial_DTI_AP_110_b2500_ADC
	##MB_Axial_DTI_AP_110_b2500_FA
	##MB_Axial_DTI_AP_110_b2500_TENSOR
	##MB_Axial_DTI_AP_110_b2500_TRACEW
	MB_Axial_DTI_PA_110_b2500=111
	##MB_Axial_DTI_PA_110_b2500_ADC
	##MB_Axial_DTI_PA_110_b2500_FA
	##MB_Axial_DTI_PA_110_b2500_TENSOR
	##MB_Axial_DTI_PA_110_b2500_TRACEW
	T1w_MPR=416
###############################
# Directory contents in Scan 2:
	##BIAS_32CH
	fmri_emotion=340
	fmri_emotion_SBRef=1
	rfMRI_REST_AP=363
	rfMRI_REST_AP_SBRef=3
	rfMRI_REST_PA=363
	rfMRI_REST_PA_SBRef=3
	SpinEchoFieldMap_AP=3
	SpinEchoFieldMap_PA=3
	T1w_MPR=416
	T2w_SPC=416
###############################


##############
# Usage is: check_incoming.sh <subject number> <parent dicom directory> <output directory>
##############
subject=$1
idir=$2
odir=$3

##############
# Please be sure to confirm the follow variables
#		dir = parent directory of where subject dicom data resides
#		odir = desired output directory
##############
dir=${idir}
if [ ! -e ${odir} ]; then mkdir ${odir}; fi



################
# Error check
################

if [ ! $# == 3 ]; then
	echo "Usage is check_incoming.sh <subject num> <parent dicom directory path> <fullpath output dir>"
	exit
fi
if [ ! -e ${dir}/${subject} ]; then 
	echo "Subject ${subject} could not be found in ${dir}"
fi

##Check with user before proceeding
echo WORKING on $subject
echo DicomDir: $dir
echo OutputDir: $odir

echo "Is this all correct? (y or n)"
read resp
if [ ! ${resp} == y ] && [ ! ${resp} == Y ]; then echo "OK please modify then rerun, exiting..."; exit; fi

#########
# BEGIN	
#########	
	
cd ${dir}/${subject}

#########
# SCAN 1
#########
rm tmpscan1
# List all scans in scan1 folder
for dirs in `ls -d  scan1/*`
do 
	#Get the name of each scan
	scan=`basename ${dirs}`
	#Point to the scan name variable set in above list	
	eval expfiles=\$$scan		
	#Test if variable was defined
	if [ ! -z $expfiles ]; then	
		#If defined, then test if number of files match the number of expected files (expfiles)
		if [ `ls scan1/${scan}/*dcm | wc -l` == $expfiles ]; then	
			ffiles=`ls scan1/${scan}/*dcm | wc -l`
			printf "OK \t%s\n" "$scan ${ffiles} Found"
			echo $scan,1 >> tmpscan1
			else 
				#If the number of files don't match, do additional test to see if the found files (ffiles) are a multiple of the expected files (expfiles)
				ffiles=`ls scan1/${scan}/*dcm | wc -l`	
				ans=`echo $ffiles%$expfiles | bc`
				#If so, there was likely a rescan
				if [ $ans == 0 ]; then					
					printf "OK \t%s\n" "$scan"
					echo $scan,2 >> tmpscan1
					continue 
				fi	
				#If not, flag it so user can check
				printf "NOT OK \t%s\n" "$scan ${ffiles} Found but Expected ${expfiles}"			
		fi
	fi  
done

#Check if user wants to convert data
echo "################################"
echo "# Would you like to convert the data to NIFTI (y or n)?"
echo "################################"
read resp
if [ ${resp} == y ] || [ ${resp} == Y ]; then  


#tmpscan1 is list of scans flagged OK for dcm2niix conversion
for scans in `cat tmpscan1`		
do
	scan=`echo $scans | awk -F, '{print $1}'`
	num=`echo $scans | awk -F, '{print $2}'`
	#If only 1 series found, then convert it normally
	if [ $num == 1 ]; then		
		echo ""
		echo "##########################"
		echo "Converting ${scan} to NIFTI.."
		echo "##########################"
		echo ""
		/Applications/MRIcroGL/dcm2niix -o ${odir} -f ${subject}-${scan}_scan1-%s -x y -z y ${dir}/${subject}/scan1/${scan}
		if [ $scan == "T1w_MPR" ] || [ $scan == "T2w_SPC" ]; then
			rm `ls -r ${odir}/*${scan}* | grep -v 'Crop'`
			echo "Renaming ${scan}..."
				a=1
				for x in `ls ${odir}/*${scan}_scan1*`
				do
					if [ $a == 1 ]; then 
					mv ${x} ${x%%.*}_nonorm.nii.gz
					fi
				let a=a+1
				done
			unset a
		fi
	#If 2 or more series found, then keep only the most recent run
	elif [ $num == 2 ]; then
		echo ""
		echo "##########################"
		echo "Converting ${scan} to NIFTI.."
		echo "##########################"
		echo ""	
		/Applications/MRIcroGL/dcm2niix -o ${odir} -f ${subject}-${scan}_scan1-%s -x y -z y ${dir}/${subject}/scan1/${scan}
		rm `ls -r ${odir}/*${scan}* | tail -n +5`
		if [ $scan == "T1w_MPR" ] || [ $scan == "T2w_SPC" ]; then
			rm `ls -r ${odir}/*${scan}* | grep -v 'Crop'`
			echo "Renaming ${scan}..."
				a=1
				for x in `ls ${odir}/*${scan}_scan1*`
				do
					if [ $a == 1 ]; then 
					mv ${x} ${x%%.*}_nonorm.nii.gz
					fi
				let a=a+1
				done
			unset a
		fi
	fi
done
rm tmpscan1
else
	echo "Ok, will not convert scan1 contents to NIFTI..."
fi

#########
# SCAN 2
#########
rm tmpscan2
# List all scans in scan2 folder
for dirs in `ls -d  scan2/*`
do 
	#Get the name of each scan
	scan=`basename ${dirs}`
	#Point to the scan name variable set in above list	
	eval expfiles=\$$scan		
	#Test if variable was defined
	if [ ! -z $expfiles ]; then	
		#If defined, then test if number of files match the number of expected files (expfiles)
		if [ `ls scan2/${scan}/*dcm | wc -l` == $expfiles ]; then	
			ffiles=`ls scan2/${scan}/*dcm | wc -l`
			printf "OK \t%s\n" "$scan ${ffiles} Found"
			echo $scan,1 >> tmpscan2
			else 
				#If the number of files don't match, do additional test to see if the found files (ffiles) are a multiple of the expected files (expfiles)
				ffiles=`ls scan2/${scan}/*dcm | wc -l`	
				ans=`echo $ffiles%$expfiles | bc`
				#If so, there was likely a rescan
				if [ $ans == 0 ]; then					
					printf "OK \t%s\n" "$scan"
					echo $scan,2 >> tmpscan2
					continue 
				fi	
				#If not, flag it so user can check
				printf "NOT OK \t%s\n" "$scan ${ffiles} Found but Expected ${expfiles}"			
		fi
	fi  
done

#Check if user wants to convert data
echo "################################"
echo "# Would you like to convert the data to NIFTI (y or n)?"
echo "################################"
read resp
if [ ${resp} == y ] || [ ${resp} == Y ]; then

#tmpscan2 is list of scans flagged OK for dcm2niix conversion
for scans in `cat tmpscan2`		
do
	scan=`echo $scans | awk -F, '{print $1}'`
	num=`echo $scans | awk -F, '{print $2}'`
	#If only 1 series found, then convert it normally
	if [ $num == 1 ]; then
		echo ""
		echo "##########################"
		echo "Converting ${scan} to NIFTI.."
		echo "##########################"
		echo ""	
		/Applications/MRIcroGL/dcm2niix -o ${odir} -f ${subject}-${scan}_scan2-%s -x y -z y ${dir}/${subject}/scan2/${scan}
		if [ $scan == "T1w_MPR" ] || [ $scan == "T2w_SPC" ]; then
			rm `ls -r ${odir}/*${scan}* | grep -v 'Crop'`
			echo "Renaming ${scan}..."
				a=1
				for x in `ls ${odir}/*${scan}_scan2*`
				do
					if [ $a == 1 ]; then 
					mv ${x} ${x%%.*}_nonorm.nii.gz
					fi
				let a=a+1
				done
			unset a
		fi
	#If 2 or more series found, then keep only the most recent run
	elif [ $num == 2 ]; then	
		echo ""
		echo "##########################"
		echo "Converting ${scan} to NIFTI.."
		echo "##########################"
		echo ""
		/Applications/MRIcroGL/dcm2niix -o ${odir} -f ${subject}-${scan}_scan2-%s -x y -z y ${dir}/${subject}/scan2/${scan}
		rm `ls -r ${odir}/*${scan}* | tail -n +5`
		if [ $scan == "T1w_MPR" ] || [ $scan == "T2w_SPC" ]; then
			rm `ls -r ${odir}/*${scan}* | grep -v 'Crop'`
			echo "Renaming ${scan}..."
				a=1
				for x in `ls ${odir}/*${scan}_scan2*`
				do
					if [ $a == 1 ]; then 
					mv ${x} ${x%%.*}_nonorm.nii.gz
					fi
				let a=a+1
				done
			unset a
		fi
	fi
done
rm tmpscan2
else
	echo "echo "Ok, will not convert scan2 contents to NIFTI..."
fi
