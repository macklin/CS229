%% Create Features %%

clear all;
clc;

% Add libraries
addpath('lib');

load data/klexp.mat

cellMatrix = [];
classification = [];

for expIdx = 1:numel(experiments)
    thisExp = experiments(expIdx);
    if isempty(thisExp.data)
        continue;
    end
    objSetNames = thisExp.data.objectSetNames;
    objMat = [];
    featureNames = {};
    for objIdx = 1:numel(objSetNames)
        objName = objSetNames{objIdx};
        objMats = thisExp.data.(objName);
        cpFeatureNames = fieldnames(objMats);
        removeIdxs = [];
        
        % Cell profiler features appear to start with capital letters
        % so lets not look at things that start with lowercase letters
        for featIdx = 1:numel(cpFeatureNames)
            if isempty(regexp(cpFeatureNames{featIdx}, '^[A-Z]', 'once'))
                removeIdxs = [removeIdxs featIdx];
            end
        end
        cpFeatureNames(removeIdxs) = [];
        
        for featIdx = 1:numel(cpFeatureNames)
            thisMat = objMats.(cpFeatureNames{featIdx});
            for channelIdx = 1:size(thisMat, 3)
                chanName = sprintf('Chan%1d', channelIdx);

                featureNames = [featureNames; sprintf('%s__%s__%s__%s', objName, cpFeatureNames{featIdx}, 'Min', chanName)];
                mins = nanmin(thisMat(:, :, channelIdx), [], 2);
                
                featureNames = [featureNames; sprintf('%s__%s__%s__%s', objName, cpFeatureNames{featIdx}, 'Max', chanName)];
                maxs = nanmax(thisMat(:, :, channelIdx), [], 2);
                
                featureNames = [featureNames; sprintf('%s__%s__%s__%s', objName, cpFeatureNames{featIdx}, 'Mean', chanName)];
                means = nanmean(thisMat(:, :, channelIdx), 2);

%                 featureNames = [featureNames; sprintf('%s__%s__%s__%s', objName, cpFeatureNames{featIdx}, 'Median', chanName)];
%                 medians = nanmedian(thisMat(:, :, channelIdx), 2);
                
                featureNames = [featureNames; sprintf('%s__%s__%s__%s', objName, cpFeatureNames{featIdx}, 'Std', chanName)];
                stds = nanstd(thisMat(:, :, channelIdx), 0, 2);

%                 objMat = [objMat mins maxs means medians stds];
                objMat = [objMat mins maxs means stds];
            end
        end
    end
    cellMatrix = [cellMatrix; objMat];
    
    prop = thisExp.prop.goodbad.store == 1;
    classification = [classification; prop];
end