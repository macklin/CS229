%% Create Features %%

% clear all;
clc;

featStruct = struct('cellMatrix', {}, 'cellMatrixNoFFT', {}, 'classification', {}, ...
    'featsToKeep', {}, 'timeCourseInfo', {});

timeCourseInfo = [struct('objectSetName', 'nuclei', 'cpProperty', 'MedianIntensity', ... 
    'channelIdx', 2, 'startFrame', 1, 'endFrame', 15')];

[cellMatrix, cellMatrixNoFFT, classification, ...
 featsToKeep, normParams, timeCourseInfo] = makeFeatures(...
                                                'data/klexp.mat', ...
                                                 [], ...
                                                 [0.90 0.05], ...
                                                 [], ...
                                                 timeCourseInfo);
                                                   
toLibSVM(cellMatrix, classification, 'klexp.train');

[cellMatrix2, cellMatrixNoFFT, classification, ...
 featsToKeep2, normParams, timeCourseInfo] = makeFeatures(...
                                                'data/klexp.mat', ...
                                                 [], ...
                                                 [0.90 0.05], ...
                                                 featsToKeep, ...
                                                 timeCourseInfo);

return;
                                                   
                                                   

% Add libraries
addpath('lib');

load data/klexp.mat

cellMatrix = [];
classification = [];
nucleiMedianIntensities = [];

usefulFeatures = {'MaxIntensity', 'MaxIntensityEdge', 'MedianIntensity', ...
    'MeanIntensity', 'MeanIntensityEdge', 'MinIntensity', 'MinIntensityEdge', ...
    'StdIntensity', 'StdIntensityEdge', 'Area', 'Perimeter', 'Solidity'};

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
%             if ~ismember(cpFeatureNames{featIdx}, usefulFeatures)
%                 removeIdxs = [removeIdxs featIdx];
%             end
        end
        cpFeatureNames(removeIdxs) = [];
        
        if strcmp(objName, 'nuclei')
            if isempty(nucleiMedianIntensities)
                nucleiMedianIntensities = objMats.MedianIntensity(:, :, 2);
            elseif size(objMats.MedianIntensity, 2) > size(nucleiMedianIntensities, 2)
                nucleiMedianIntensities = [nucleiMedianIntensities nan(size(nucleiMedianIntensities, 1), size(objMats.MedianIntensity, 2) - size(nucleiMedianIntensities, 2))];
                nucleiMedianIntensities = [nucleiMedianIntensities; objMats.MedianIntensity(:, :, 2)];
            else
                nucleiMedianIntensities = [nucleiMedianIntensities; [objMats.MedianIntensity(:, :, 2) nan(size(objMats.MedianIntensity, 1), size(nucleiMedianIntensities, 2) - size(objMats.MedianIntensity, 2))]];
            end
        end
        
        for featIdx = 1:numel(cpFeatureNames)
            thisMat = objMats.(cpFeatureNames{featIdx});
            
            for channelIdx = 1:size(thisMat, 3)
                chanName = sprintf('Chan%1d', channelIdx);
                
                thisMatChan = thisMat(:, :, channelIdx);

                featureNames = [featureNames; sprintf('%s__%s__%s__%s', objName, cpFeatureNames{featIdx}, 'MissingAtBeginning')];
                missingAtBeg = isnan(thisMatChan(:, 1));
                
                featureNames = [featureNames; sprintf('%s__%s__%s__%s', objName, cpFeatureNames{featIdx}, 'Min', chanName)];
                mins = nanmin(thisMatChan(:, :), [], 2);
                mins(isnan(mins)) = 0;
                
                featureNames = [featureNames; sprintf('%s__%s__%s__%s', objName, cpFeatureNames{featIdx}, 'Max', chanName)];
                maxs = nanmax(thisMatChan(:, :), [], 2);
                maxs(isnan(maxs)) = 0;
                
                featureNames = [featureNames; sprintf('%s__%s__%s__%s', objName, cpFeatureNames{featIdx}, 'Mean', chanName)];
                means = nanmean(thisMatChan(:, :), 2);
                means(isnan(means)) = 0;

%                 featureNames = [featureNames; sprintf('%s__%s__%s__%s', objName, cpFeatureNames{featIdx}, 'Median', chanName)];
%                 medians = nanmedian(thisMat(:, :, channelIdx), 2);
                
                featureNames = [featureNames; sprintf('%s__%s__%s__%s', objName, cpFeatureNames{featIdx}, 'Std', chanName)];
                stds = nanstd(thisMatChan(:, :), 0, 2);
                stds(isnan(stds)) = 0;

                featureNames = [featureNames; sprintf('%s__%s__%s__%s', objName, cpFeatureNames{featIdx}, 'CV', chanName)];
                cv = stds ./ (means + eps);
                
                deriv = diff(thisMatChan, 1, 2);
               
                featureNames = [featureNames; sprintf('%s__%s__%s__%s', objName, cpFeatureNames{featIdx}, 'derivMin', chanName)];
                derivMin = nanmin(deriv(:, :), [], 2);
                derivMin(isnan(derivMin)) = 0;
                
                featureNames = [featureNames; sprintf('%s__%s__%s__%s', objName, cpFeatureNames{featIdx}, 'derivMax', chanName)];
                derivMax = nanmax(deriv(:, :), [], 2);
                derivMax(isnan(derivMax)) = 0;
                              
                featureNames = [featureNames; sprintf('%s__%s__%s__%s', objName, cpFeatureNames{featIdx}, 'derivMean', chanName)];
                derivMean = nanmean(deriv(:, :), 2);
                derivMean(isnan(derivMean)) = 0;
                
                featureNames = [featureNames; sprintf('%s__%s__%s__%s', objName, cpFeatureNames{featIdx}, 'derivStd', chanName)];
                derivStd = nanstd(deriv(:, :), 0, 2);
                derivStd(isnan(derivStd)) = 0;
                
                featureNames = [featureNames; sprintf('%s__%s__%s__%s', objName, cpFeatureNames{featIdx}, 'derivCV', chanName)];
                derivCV = derivStd ./ (derivMean + eps);
                
%                 objMat = [objMat mins maxs means medians stds];
                objMat = [objMat missingAtBeg mins maxs means stds cv derivMin derivMax derivMean derivStd derivCV];
            end
        end
    end
    cellMatrix = [cellMatrix; objMat];
    
    prop = thisExp.prop.goodbad.store == 1;
    classification = [classification; prop];
end

staticFeatures = max(cellMatrix) == min(cellMatrix);

cellMatrix(:, staticFeatures) = [];
featureNames(staticFeatures) = [];

corrFeats = abs(corr(cellMatrix)) > 0.90;
ignoreMatrix = triu(toeplitz(ones(size(corrFeats, 1), 1)));
corrFeats = corrFeats .* (1-ignoreMatrix);
removeFeats = sum(corrFeats, 1) > 0;

cellMatrix(:, removeFeats) = [];
featureNames(removeFeats) = [];

uncorrFeats = abs(corr(classification, cellMatrix)) < 0.05;
removeFeats = uncorrFeats;

cellMatrix(:, removeFeats) = [];
featureNames(removeFeats) = [];

cellMatrix = cellMatrix ./ repmat(sqrt(sum(cellMatrix.^2, 1)), size(cellMatrix, 1), 1);
cellMatrix = cellMatrix - min(min(cellMatrix)) + 1e-4;

A = zeros(size(nucleiMedianIntensities));
for i = 1:size(A, 1)
A(i, :) = imputeMissing(nucleiMedianIntensities(i, :));
end
B = diff(A, 1, 2);
B = B - repmat(mean(B, 2), 1, size(B, 2));
B = B ./ repmat(var(B, 1, 2), 1, size(B, 2));
area = getCpProperty('data/klexp.mat', 'nuclei', 'Area', 1);
F = abs(fft(A(:, 1:15), [], 2));
F = F(:, 1:ceil(size(F,2)/2));
G = abs(fft(B(:, 1:15), [], 2));
G = G(:, 1:ceil(size(G,2)/2));
G = G ./ repmat(sqrt(sum(G.^2, 1)), size(G, 1), 1);
G = G - min(min(G));
% F(isnan(nucleiMedianIntensities(:, 1)), :) = 0;
cellMatrixF = [ cellMatrix (nanmean(area,2) > 150) repmat(isnan(nucleiMedianIntensities(:, 1)), 1, 1) F];
% cellMatrixF = cellMatrixF - repmat(mean(cellMatrixF, 2), 1, size(cellMatrixF, 2));
% cellMatrixF = cellMatrixF ./ repmat(var(cellMatrixF, 1, 2), 1, size(cellMatrixF, 2));
% cellMatrixF = cellMatrixF ./ repmat(sqrt(sum(cellMatrixF.^2, 1)), size(cellMatrixF, 1), 1);
% cellMatrixF = cellMatrixF - min(min(cellMatrixF));


% corrFeats = abs(corr(cellMatrixF)) > 0.80;
% ignoreMatrix = triu(toeplitz(ones(size(corrFeats, 1), 1)));
% corrFeats = corrFeats .* (1-ignoreMatrix);
% removeFeats = sum(corrFeats, 1) > 0;
% 
% cellMatrixF(:, removeFeats) = [];

toLibSVM(cellMatrixF, classification, 'klexp.train');
