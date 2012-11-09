clear all;
clc;

folders = {
    '/covertlab/home/share/Sergi/120803/Run2/Output/Pos8/'
    '/covertlab/home/share/Sergi/120803/Run2/Output/Pos9/'
    '/covertlab/home/share/Sergi/120803/Run2/Output/Pos10/'
    '/covertlab/home/share/Sergi/120803/Run2/Output/Pos11/'
    '/covertlab/home/share/Sergi/120803/Run2/Output/Pos12/'
    '/covertlab/home/share/Sergi/120803/Run2/Output/Pos13/'
    '/covertlab/home/share/Sergi/120803/Run2/Output/Pos14/'
    '/covertlab/home/share/Sergi/120803/Run2/Output/Pos15/'
    '/covertlab/home/share/Sergi/120803/Run2/Output/Pos20/'
    '/covertlab/home/share/Sergi/120803/Run2/Output/Pos21/'
    };

outdir = '/data/mlproject';

clc;

experiments = [];

for folderNum = 1:numel(folders)
    clear data;
    clear properties;
    dataFileName = sprintf('%s%scpDataTracked.mat', folders{folderNum}, filesep);
    propFileName = sprintf('%s%sguiTracked.mat', folders{folderNum}, filesep);
    if ~exist(dataFileName, 'file')
        fprintf('Skipping %s: dataFile does not exist\n', dataFileName);
        continue
    end
    if ~exist(propFileName, 'file')
        fprintf('Skipping %s: dataFile does not exist\n', propFileName);
        continue
    end
    load(dataFileName);
    load(propFileName);
    if ~exist('properties', 'var')
        fprintf('Skipping %s: old gui output format\n', propFileName);
        continue;
    end
    fprintf('%d ', folderNum);
    for objSetIdx = 1:numel(data.objectSetNames)
        fprintf('%s ', data.objectSetNames{objSetIdx});
    end
    fprintf('\n');
    experiments(folderNum).data = data;
    experiments(folderNum).prop = properties;
end

outFileName = sprintf('%s%ssrexp.mat', outdir, filesep);
save(outFileName, 'experiments');