function user = createListing(user)
    fprintf('\n=== Create a New Listing ===\n');
    title = input('Enter product title: ', 's');
    description = input('Enter product description: ', 's');
    price = input('Enter product price: ');

    newListing.title = title;
    newListing.description = description;
    newListing.price = price;
    newListing.sellerName = user.name;
    newListing.sellerEmail = user.email;

    if isempty(user.myListings)
        user.myListings = newListing;
    else
        user.myListings(end+1) = newListing;
    end

    if exist('listings.mat', 'file')
        load('listings.mat', 'allListings');
    else
        allListings = [];
    end

    if isempty(allListings)
        allListings = newListing;
    else
        allListings(end+1) = newListing;
    end
    save('listings.mat', 'allListings');

    fprintf('Listing "%s" created successfully!\n', title);
end
