function soldTitles = getSoldItemTitles(sellerEmail)
    soldTitles = {};
    allFiles = dir('users/*.mat');
    for i = 1:length(allFiles)
        data = load(fullfile('users', allFiles(i).name));
        if isfield(data, 'user') && isfield(data.user, 'purchasedProducts')
            for j = 1:length(data.user.purchasedProducts)
                p = data.user.purchasedProducts(j);
                if strcmp(p.sellerEmail, sellerEmail)
                    soldTitles{end+1} = p.title; %#ok<AGROW>
                end
            end
        end
    end
end
