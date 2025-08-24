function user = searchAndBuy(user)
    fprintf('\n=== Search Listings ===\n');
    if ~exist('listings.mat', 'file')
        fprintf('No listings available yet.\n');
        return;
    end

    load('listings.mat', 'allListings');
    otherListings = allListings(~strcmp({allListings.sellerEmail}, user.email));

    keyword = input('Search by keyword (or press Enter to view all): ', 's');
    if ~isempty(keyword)
        matches = contains(lower({otherListings.title}), lower(keyword)) | ...
                  contains(lower({otherListings.description}), lower(keyword));
        searchResults = otherListings(matches);
    else
        searchResults = otherListings;
    end

    if isempty(searchResults)
        fprintf('No listings match your search.\n');
        return;
    end

    for i = 1:length(searchResults)
        l = searchResults(i);
        fprintf('%d. %s - $%.2f\n   Description: %s\n   Seller: %s\n', ...
            i, l.title, l.price, l.description, l.sellerName);
    end

    index = input('\nEnter the number of the product to buy (-1 to cancel): ');
    if index == -1 || index < 1 || index > length(searchResults)
        fprintf('Invalid selection.\n');
        return;
    end

    selected = searchResults(index);

    % Simulate payment
    input('Enter your 16-digit credit card number: ', 's');
    input('Enter expiry date (MM/YY): ', 's');
    input('Enter CVV: ', 's');
    address = input('Enter your shipping address: ', 's');

    fprintf('Processing payment...\n');
    pause(1);
    fprintf('Payment successful!\n');

    purchase = selected;
    purchase.address = address;
    purchase.date = datestr(now);

    if isempty(user.purchasedProducts)
        user.purchasedProducts = purchase;
    else
        user.purchasedProducts(end+1) = purchase;
    end

    % Remove from global listings
    load('listings.mat', 'allListings');
    allListings = allListings(~(strcmp({allListings.title}, selected.title) & ...
                                strcmp({allListings.sellerEmail}, selected.sellerEmail)));
    save('listings.mat', 'allListings');

    % Remove from seller’s listings
    sellerSafeEmail = replace(selected.sellerEmail, {'@', '.'}, {'_at_', '_dot_'});
    sellerFile = fullfile('users', [sellerSafeEmail '_data.mat']);
    if exist(sellerFile, 'file')
        load(sellerFile, 'user');
        user.myListings = user.myListings(~strcmp({user.myListings.title}, selected.title));
        save(sellerFile, 'user');
    end

    fprintf('Receipt generated. Thank you!\n');
end
