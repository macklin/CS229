clear all;
clc;

folders = {
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos0'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos1'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos2'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos3'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos4'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos5'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos6'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos7'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos8'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos9'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos10'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos11'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos12'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos13'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos14'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos15'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos16'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos17'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos18'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos19'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos20'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos21'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos22'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos23'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos24'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos25'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos26'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos27'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos28'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos29'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos30'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos31'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos32'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos33'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos34'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos35'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos36'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos37'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos38'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos39'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos40'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos41'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos42'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos43'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos44'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos45'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos46'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos47'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos48'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos49'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos50'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos51'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos52'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos53'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos54'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos55'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos56'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos57'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos58'
    '/covertlab/home/share/Keara/Derek/GUIAnalysis/09112012/Pos59'
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

outFileName = sprintf('%s%sklexp.mat', outdir, filesep);
save(outFileName, 'experiments');