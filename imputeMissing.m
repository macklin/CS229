function row = imputeMissing( row )
% Nothing fancy.
% If row is:
% [nan nan nan 1 2 nan 9 8 nan 8 7 6 nan nan nan nan]
% returns
% [1 1 1 1 2 2 9 8 8 8 7 6 6 6 6 6]
    firstGoodIdx = find(~isnan(row), 1);
    v = row(firstGoodIdx:end);
    nanIdxs = zeros(size(v));
    newNanIdxs = isnan(v);

    while norm(nanIdxs-newNanIdxs) > 1e-6
        nanIdxs = newNanIdxs;
        sNanIdxs = logical([nanIdxs(2:end) 0]);
        v(nanIdxs) = v(sNanIdxs);
        newNanIdxs = isnan(v);
    end

    row = [row(1:(firstGoodIdx-1)) v];

    nanIdxs = zeros(size(row));
    newNanIdxs = isnan(row);

    while norm(nanIdxs-newNanIdxs) > 1e-6
        nanIdxs = newNanIdxs;
        sNanIdxs = logical([0 nanIdxs(1:end-1)]);
        row(nanIdxs) = row(sNanIdxs);
        newNanIdxs = isnan(row);
    end

end

