#!/bin/bash

##############
# Written by Eric Kan
# 2/2/2017
# Use however you like
#
# Inputs:  	<subject number> - Subject ID
#			<idir> - input directory, parent directory of where subject NIFTI files are located
#
# Outputs:	Renamed NIFTI files
##############

################
# Error check
################

if [ ! $# == 2 ]; then
	echo "Usage is simplify_name.sh <subject num> <path to NIFTI files>"
	exit
fi

sub=$1
idir=$2

cd ${idir}
if [ -e ${sub}-EMO_SpinEchoFieldMap_AP*nii.gz ]; then
	echo "Found `ls ${sub}-EMO_SpinEchoFieldMap_AP*nii.gz` will rename to ${sub}-emo_fm_ap.nii.gz"
	mv ${sub}-EMO_SpinEchoFieldMap_AP*nii.gz ${sub}-emo_fm_ap.nii.gz
fi

if [ -e ${sub}-EMO_SpinEchoFieldMap_PA*nii.gz ]; then
	echo "Found `ls ${sub}-EMO_SpinEchoFieldMap_PA*nii.gz` will rename to ${sub}-emo_fm_pa.nii.gz"
	mv ${sub}-EMO_SpinEchoFieldMap_PA*nii.gz ${sub}-emo_fm_pa.nii.gz
fi

if [ -e ${sub}-fmri_emotion_SBRef*nii.gz ]; then
	echo "Found `ls ${sub}-fmri_emotion_SBRef*nii.gz` will rename to ${sub}-emo_SBRef.nii.gz"
	mv ${sub}-fmri_emotion_SBRef*nii.gz ${sub}-emo_SBRef.nii.gz
fi

if [ -e ${sub}-fmri_emotion*nii.gz ]; then
	echo "Found `ls ${sub}-fmri_emotion*nii.gz` will rename to ${sub}-fmri_emo.nii.gz"
	mv ${sub}-fmri_emotion*nii.gz ${sub}-fmri_emo.nii.gz
fi

if [ -e ${sub}-fmri_foodcues_SBRef*nii.gz ]; then
	echo "Found `ls ${sub}-fmri_foodcues_SBRef*nii.gz` will rename to ${sub}-fc_SBRef.nii.gz"
	mv ${sub}-fmri_foodcues_SBRef*nii.gz ${sub}-fc_SBRef.nii.gz
fi

if [ -e ${sub}-fmri_foodcues*nii.gz ]; then
	echo "Found `ls ${sub}-fmri_foodcues*nii.gz` will rename to ${sub}-fmri_fc.nii.gz"
	mv ${sub}-fmri_foodcues*nii.gz ${sub}-fmri_fc.nii.gz
fi

if [ -e ${sub}-FOOD_SpinEchoFieldMap_AP*nii.gz ]; then
	echo "Found `ls ${sub}-FOOD_SpinEchoFieldMap_AP*nii.gz` will rename to ${sub}-fc_fm_ap.nii.gz"
	mv ${sub}-FOOD_SpinEchoFieldMap_AP*nii.gz ${sub}-fc_fm_ap.nii.gz
fi

if [ -e ${sub}-FOOD_SpinEchoFieldMap_PA*nii.gz ]; then
	echo "Found `ls ${sub}-FOOD_SpinEchoFieldMap_PA*nii.gz` will rename to ${sub}-fc_fm_pa.nii.gz"
	mv ${sub}-FOOD_SpinEchoFieldMap_PA*nii.gz ${sub}-fc_fm_pa.nii.gz
fi

if [ -e ${sub}-MB_Axial_DTI_AP_110_b2500*bval ]; then
	echo "Found `ls ${sub}-MB_Axial_DTI_AP_110_b2500*bval` will rename to ${sub}-dti_ap.bval"
	mv ${sub}-MB_Axial_DTI_AP_110_b2500*bval ${sub}-dti_ap.bval
fi

if [ -e ${sub}-MB_Axial_DTI_AP_110_b2500*bvec ]; then
	echo "Found `ls ${sub}-MB_Axial_DTI_AP_110_b2500*bvec` will rename to ${sub}-dti_ap.bvec"
	mv ${sub}-MB_Axial_DTI_AP_110_b2500*bvec ${sub}-dti_ap.bvec
fi

if [ -e ${sub}-MB_Axial_DTI_AP_110_b2500*nii.gz ]; then
	echo "Found `ls ${sub}-MB_Axial_DTI_AP_110_b2500*nii.gz` will rename to ${sub}-dti_ap.nii.gz"
	mv ${sub}-MB_Axial_DTI_AP_110_b2500*nii.gz ${sub}-dti_ap.nii.gz
fi


if [ -e ${sub}-MB_Axial_DTI_PA_110_b2500*bval ]; then
	echo "Found `ls ${sub}-MB_Axial_DTI_PA_110_b2500*bval` will rename to ${sub}-dti_pa.bval"
	mv ${sub}-MB_Axial_DTI_PA_110_b2500*bval ${sub}-dti_pa.bval
fi

if [ -e ${sub}-MB_Axial_DTI_PA_110_b2500*bvec ]; then
	echo "Found `ls ${sub}-MB_Axial_DTI_PA_110_b2500*bvec` will rename to ${sub}-dti_pa.bvec"
	mv ${sub}-MB_Axial_DTI_PA_110_b2500*bvec ${sub}-dti_pa.bvec
fi

if [ -e ${sub}-MB_Axial_DTI_PA_110_b2500*nii.gz ]; then
	echo "Found `ls ${sub}-MB_Axial_DTI_PA_110_b2500*nii.gz` will rename to ${sub}-dti_pa.nii.gz"
	mv ${sub}-MB_Axial_DTI_PA_110_b2500*nii.gz ${sub}-dti_pa.nii.gz
fi

if [ -e ${sub}-rfMRI_REST_AP_SBRef*nii.gz ]; then
	echo "Found `ls ${sub}-rfMRI_REST_AP_SBRef*nii.gz` will rename to ${sub}-rs_ap_SBRef.nii.gz"
	mv ${sub}-rfMRI_REST_AP_SBRef*nii.gz ${sub}-rs_ap_SBRef.nii.gz 
fi

if [ -e ${sub}-rfMRI_REST_AP*nii.gz ]; then
	echo "Found `ls ${sub}-rfMRI_REST_AP*nii.gz` will rename to ${sub}-fmri_rs_ap.nii.gz"
	mv ${sub}-rfMRI_REST_AP*nii.gz ${sub}-fmri_rs_ap.nii.gz
fi


if [ -e ${sub}-rfMRI_REST_PA_SBRef*nii.gz ]; then
	echo "Found `ls ${sub}-rfMRI_REST_PA_SBRef*nii.gz` will rename to ${sub}-rs_pa_SBRef.nii.gz"
	mv ${sub}-rfMRI_REST_PA_SBRef*nii.gz ${sub}-rs_pa_SBRef.nii.gz
fi

if [ -e ${sub}-rfMRI_REST_PA*nii.gz ]; then
	echo "Found `ls ${sub}-rfMRI_REST_PA*nii.gz` will rename to ${sub}-fmri_rs_pa.nii.gz"
	mv ${sub}-rfMRI_REST_PA*nii.gz ${sub}-fmri_rs_pa.nii.gz
fi

if [ -e ${sub}-SpinEchoFieldMap_AP*nii.gz ]; then
	echo "Found `ls ${sub}-SpinEchoFieldMap_AP*nii.gz` will rename to ${sub}-rs_fm_ap.nii.gz"
	mv ${sub}-SpinEchoFieldMap_AP*nii.gz ${sub}-rs_fm_ap.nii.gz
fi

if [ -e ${sub}-SpinEchoFieldMap_PA*nii.gz ]; then
	echo "Found `ls ${sub}-SpinEchoFieldMap_PA*nii.gz` will rename to ${sub}-rs_fm_pa.nii.gz"
	mv ${sub}-SpinEchoFieldMap_PA*nii.gz ${sub}-rs_fm_pa.nii.gz
fi


if [ -e ${sub}-T1w_MPR_scan2*nonorm*nii.gz ]; then
	echo "Found `ls ${sub}-T1w_MPR_scan2*nonorm*nii.gz` will rename to ${sub}-t1w_scan2_nonorm.nii.gz"
	mv ${sub}-T1w_MPR_scan2*nonorm*nii.gz ${sub}-t1w_scan2_nonorm.nii.gz
fi

if [ -e ${sub}-T1w_MPR_scan2*nii.gz ]; then
	echo "Found `ls ${sub}-T1w_MPR_scan2*nii.gz` will rename to ${sub}-t1w_scan2.nii.gz"
	mv ${sub}-T1w_MPR_scan2*nii.gz ${sub}-t1w_scan2.nii.gz
fi

if [ -e ${sub}-T1w_MPR_scan1*nonorm*nii.gz ]; then
	echo "Found `ls ${sub}-T1w_MPR_scan1*nonorm*nii.gz` will rename to ${sub}-t1w_scan1_nonorm.nii.gz"
	mv ${sub}-T1w_MPR_scan1*nonorm*nii.gz ${sub}-t1w_scan1_nonorm.nii.gz
fi

if [ -e ${sub}-T1w_MPR_scan1*nii.gz ]; then
	echo "Found `ls ${sub}-T1w_MPR_scan1*nii.gz` will rename to ${sub}-t1w_scan1.nii.gz"
	mv ${sub}-T1w_MPR_scan1*nii.gz ${sub}-t1w_scan1.nii.gz
fi

if [ -e ${sub}-T2w_SPC_scan1*nonorm*nii.gz ]; then
	echo "Found `ls ${sub}-T2w_SPC_scan1*nonorm*nii.gz` will rename to ${sub}-t2w_scan1_nonorm.nii.gz"
	mv ${sub}-T2w_SPC_scan1*nonorm*nii.gz ${sub}-t2w_scan1_nonorm.nii.gz
fi

if [ -e ${sub}-T2w_SPC_scan1*nii.gz ]; then
	echo "Found `ls ${sub}-T2w_SPC_scan1*nii.gz` will rename to ${sub}-t2w_scan1.nii.gz"
	mv ${sub}-T2w_SPC_scan1*nii.gz ${sub}-t2w_scan1.nii.gz
fi

if [ -e ${sub}-T2w_SPC_scan2*nonorm*nii.gz ]; then
	echo "Found `ls ${sub}-T2w_SPC_scan2*nonorm*nii.gz` will rename to ${sub}-t2w_scan2_nonorm.nii.gz"
	mv ${sub}-T2w_SPC_scan2*nonorm*nii.gz ${sub}-t2w_scan2_nonorm.nii.gz
fi

if [ -e ${sub}-T2w_SPC_scan2*nii.gz ]; then
	echo "Found `ls ${sub}-T2w_SPC_scan2*nii.gz` will rename to ${sub}-t2w_scan2.nii.gz"
	mv ${sub}-T2w_SPC_scan2*nii.gz ${sub}-t2w_scan2.nii.gz
fi


