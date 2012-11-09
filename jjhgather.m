clear all;
clc;

folders = {
    '/covertlab/home/share/jake/clones_cp/2011-06-17_clones/E05-1_0/'
    '/covertlab/home/share/jake/clones_cp/2011-06-17_clones/E06-1_0/'
    '/covertlab/home/share/jake/clones_cp/2011-06-17_clones/E09-1_0/'
    '/covertlab/home/share/jake/clones_cp/2011-06-27_clones/E08-1_0/'
    '/covertlab/home/share/jake/clones_cp/2011-06-27_clones/E11-1_0/'
    '/covertlab/home/share/jake/clones_cp/2011-06-28_clones/E05-1_0/'
    '/covertlab/home/share/jake/clones_cp/2011-06-28_clones/E05-1_0/'
    '/covertlab/home/share/jake/clones_cp/2011-06-29_clones/E09-1_0/'
    };

outdir = '/data/mlproject';

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

outFileName = sprintf('%s%sjjhexp.mat', outdir, filesep);
save(outFileName, 'experiments');