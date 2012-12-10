function propMatrix = getCpProperty(expFile, objectSetName, cpProperty, channelIdx)
    if ~isempty(whos('experiments', '-file', expFile))
        load(expFile, 'experiments');
    else
        load(expFile, 'data');
        experiments = struct('data', data);
    end
    propMatrix = [];
    for expIdx = 1:numel(experiments)
        thisExp = experiments(expIdx);
        objMats = thisExp.data.(objectSetName);
        
        if isempty(propMatrix)
            propMatrix = objMats.(cpProperty)(:, :, channelIdx);
        elseif size(objMats.(cpProperty), 2) > size(propMatrix, 2)
            propMatrix = [propMatrix nan(size(propMatrix, 1), size(objMats.(cpProperty), 2) - size(propMatrix, 2))];
            propMatrix = [propMatrix; objMats.(cpProperty)(:, :, channelIdx)];
        else
            propMatrix = [propMatrix; [objMats.(cpProperty)(:, :, channelIdx) nan(size(objMats.(cpProperty), 1), size(propMatrix, 2) - size(objMats.(cpProperty), 2))]];
        end
    end

end

