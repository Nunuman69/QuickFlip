function user = removeListing(user)
    fprintf('\n=== Remove a Listing ===\n');
    if isempty(user.myListings)
        fprintf('You have no listings to remove.\n');
        return;
    end

    soldItems = getSoldItemTitles(user.email);

    for i = 1:length(user.myListings)
        l = user.myListings(i);
        if ismember(l.title, soldItems)
            fprintf('%d. [SOLD] %s - $%.2f (Cannot be removed)\n', i, l.title, l.price);
        else
            fprintf('%d. %s - $%.2f\n   Description: %s\n', i, l.title, l.price, l.description);
        end
    end

    index = input('\nEnter the number of the listing to remove: ');
    if index < 1 || index > length(user.myListings)
        fprintf('Invalid selection.\n');
        return;
    end

    if ismember(user.myListings(index).title, soldItems)
        fprintf('Cannot remove a listing that has already been sold.\n');
        return;
    end

    removed = user.myListings(index);
    user.myListings(index) = [];

    if exist('listings.mat', 'file')
        load('listings.mat', 'allListings');
        allListings = allListings(~(strcmp({allListings.sellerEmail}, removed.sellerEmail) & ...
                                  strcmp({allListings.title}, removed.title)));
        save('listings.mat', 'allListings');
    end

    fprintf('Listing removed successfully.\n');
end
