function saveModel( model, modelType, featsToKeep, timeCourseInfo, normParams, fileName )
    save(fileName, 'model', 'modelType', 'featsToKeep', 'timeCourseInfo', 'normParams');
end

