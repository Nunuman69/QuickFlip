function viewSoldListings(currentUser)
    fprintf('\n=== Products You Have Sold ===\n\n');
    allFiles = dir('users/*.mat');
    soldCount = 0;
    for i = 1:length(allFiles)
        load(fullfile('users', allFiles(i).name), 'user');
        if isfield(user, 'purchasedProducts')
            for j = 1:length(user.purchasedProducts)
                p = user.purchasedProducts(j);
                if strcmp(p.sellerEmail, currentUser.email)
                    fprintf('- %s sold to %s on %s\n', p.title, user.name, p.date);
                    soldCount = soldCount + 1;
                end
            end
        end
    end
    if soldCount == 0
        fprintf('No products sold yet.\n\n');
    end
end
