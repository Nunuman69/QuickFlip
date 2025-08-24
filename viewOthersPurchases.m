function viewOthersPurchases(currentUser)
    fprintf('\n=== Items Purchased by Other Users ===\n\n');
    allFiles = dir('users/*.mat');
    found = false;
    for i = 1:length(allFiles)
        load(fullfile('users', allFiles(i).name), 'user');
        if isfield(user, 'purchasedProducts')
            for p = user.purchasedProducts
                if ~strcmp(user.email, currentUser.email)
                    fprintf('- %s bought from %s by %s on %s\n', ...
                        p.title, p.sellerName, user.name, p.date);
                    found = true;
                end
            end
        end
    end
    if ~found
        fprintf('No purchases by others found.\n');
    end
end
