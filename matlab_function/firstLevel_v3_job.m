%-----------------------------------------------------------------------
% Job saved on 07-Mar-2019 13:32:24 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7487)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------

clear all

defThres = 0.2;
stimDuration = 20;
currApproach = ['spm12', num2str(stimDuration)];

%cd '/data/EFAT/EFAT_output/HC/datasink/norm_spm';
[data_path ID] = fileparts(pwd);
ID2 = ID(1:7);
% def_path = fullfile(data_path, ID);

reg_path = fullfile('/data/EFAT/EFAT_output/HC/datasink/preproc', ID2, 'task-EFAT');
data_path = fullfile('/data/EFAT/EFAT_RawData/tsv_files');

disp(['ID = ' ID2]);
disp(['Approach = ' currApproach]);
disp(['pwd = ' pwd])

%% Path containing data
% path for confounding factors
move_path_origin1 = fullfile(reg_path, 'run-01', [ID '_task-EFAT_run-01_bold.par'] ); 
move_path_origin2 = fullfile(reg_path, 'run-02', [ID '_task-EFAT_run-02_bold.par'] ); 

disp('movement path defined')
%% create "R" variable from movement_regressor matrix and save
% run1
[data1, header1, ] = tsvread(move_path_origin1);
R = data1(2:end, (end-5):end);  % remove the first row, 26-31 columns --> movement regressors
save func/movement_regressors_for_epi_01.mat R 
move_path_run1 = fullfile(reg_path, 'movement_regressors_for_epi_01.mat');

% run2
[data2, header2, ] = tsvread(move_path_origin2);
R = data2(2:end, (end-5):end);  % remove the first row, 26-31 columns --> movement regressors
save func/movement_regressors_for_epi_02.mat R 
move_path_run2 = fullfile(reg_path, 'movement_regressors_for_epi_02.mat');


%%
[run1_angry, header_run1_angry, ] = tsvread( fullfile(data_path, [ID2, '_angry_run-01.tsv']));
[run1_shapes, header_run1_shapes, ] = tsvread( fullfile(data_path, [ID2, '_shapes_run-01.tsv']));
[run1_fear, header_run1_fear, ] = tsvread( fullfile(data_path, [ID2, '_fear_run-01.tsv']));
[run1_happy, header_run1_happy, ] = tsvread( fullfile(data_path, [ID2, '_happy_run-01.tsv']));
[run1_sad, header_run1_sad, ] = tsvread( fullfile(data_path, [ID2, '_sad_run-01.tsv']));

[run2_angry, header_run2_angry, ] = tsvread( fullfile(data_path, [ID2, '_angry_run-02.tsv']));
[run2_shapes, header_run2_shapes, ] = tsvread( fullfile(data_path, [ID2, '_shapes_run-02.tsv']));
[run2_fear, header_run2_fear, ] = tsvread( fullfile(data_path, [ID2, '_fear_run-02.tsv']));
[run2_happy, header_run2_happy, ] = tsvread( fullfile(data_path, [ID2, '_happy_run-02.tsv']));
[run2_sad, header_run2_sad, ] = tsvread( fullfile(data_path, [ID2, '_sad_run-02.tsv']));

%load( fullfile(reg_path, [ID '_IQ_run1.mat'] ) )
%load( fullfile(reg_path, [ID '_IQ_run2.mat'] ) )

disp('Runs 1-2 values loaded')

%% Initialize SPM defaults
spm('defaults', 'FMRI');
spm_jobman('initcfg'); % SPM8 only

%%
%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 4252 $)
%-----------------------------------------------------------------------

%% run 1
matlabbatch{1}.spm.stats.fmri_spec.dir = {'/data/EFAT/EFAT_output/spm12'};
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;

% rescan files
epipath = fullfile('/data/EFAT/EFAT_output/HC/datasink/norm_spm', ID, 'run-01')
tmpFiles = dir(fullfile(epipath, 'wfwhm-8_ssub*run-01*bold.nii'));   % find the file
% Here lines differ for 3D vs. 4D %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is for 4D multiple files
% get herder information to read a 4D file
tmpHdr = spm_vol( fullfile(epipath, tmpFiles.name) );
f_list_length = size(tmpHdr, 1);  % number of 3d volumes
for jx = 1:f_list_length
    scanFiles{jx,1} = [epipath '/' tmpFiles.name ',' num2str(jx) ] ; % add numbers in the end
    % End of difference for 3D vs. 4D %%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

%% 
matlabbatch{1}.spm.stats.fmri_spec.sess(1).scans = scanFiles;
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).name = 'angry'; 
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).onset = run1_angry(2:end, 2); 
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).duration = 20;
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).tmod = 0;

matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).name = 'shapes'; 
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).onset = run1_shapes(2:end, 2); 
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).duration = 20;
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).tmod = 0;

matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).name = 'fear'; 
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).onset = run1_fear(2:end, 2); 
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).duration = 20;
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).tmod = 0;

matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).name = 'happy'; 
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).onset = run1_happy(2:end, 2); 
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).duration = 20;
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).tmod = 0;

matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(5).name = 'sad'; 
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(5).onset = run1_sad(2:end, 2); 
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(5).duration = 20;
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(5).tmod = 0;

%matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond.orth = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi_reg = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(1).hpf = 128;

%% run2
matlabbatch = [];
% rescan files
epipath = fullfile('/data/EFAT/EFAT_output/HC/datasink/norm_spm', ID, 'run-02')
tmpFiles = dir(fullfile(epipath, 'wfwhm-8_ssub*run-02*bold.nii'));   % find the file
% Here lines differ for 3D vs. 4D %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is for 4D multiple files
% get herder information to read a 4D file
tmpHdr = spm_vol( fullfile(epipath, tmpFiles.name) );
f_list_length = size(tmpHdr, 1);  % number of 3d volumes
for jx = 1:f_list_length
    scanFiles{jx,1} = [epipath '/' tmpFiles.name ',' num2str(jx) ] ; % add numbers in the end
    % End of difference for 3D vs. 4D %%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

%%
matlabbatch{1}.spm.stats.fmri_spec.sess(2).scans = scanFiles;
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(1).name = 'angry'; 
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(1).onset = run2_angry(2:end, 2); 
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(1).duration = 20;
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(1).tmod = 0;

matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(2).name = 'shapes'; 
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(2).onset = run2_shapes(2:end, 2); 
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(2).duration = 20;
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(2).tmod = 0;

matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(3).name = 'fear'; 
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(3).onset = run2_fear(2:end, 2); 
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(3).duration = 20;
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(3).tmod = 0;

matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(4).name = 'happy'; 
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(4).onset = run2_happy(2:end, 2); 
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(4).duration = 20;
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(4).tmod = 0;

matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(5).name = 'sad'; 
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(5).onset = run2_sad(2:end, 2); 
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(5).duration = 20;
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(5).tmod = 0;

%matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond.orth = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(2).multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(2).multi_reg = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(2).hpf = 128;

%% These are for all 2 runs
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.2;
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';

%% run model specification
spm_jobman('run', matlabbatch)
disp('categorical model is specified')
