function user = updateListing(user)
    fprintf('\n=== Update a Listing ===\n');
    if isempty(user.myListings)
        fprintf('You have no listings to update.\n');
        return;
    end

    load('users/*.mat');
    soldItems = getSoldItemTitles(user.email);

    for i = 1:length(user.myListings)
        l = user.myListings(i);
        if ismember(l.title, soldItems)
            fprintf('%d. [SOLD] %s - $%.2f (Cannot be updated)\n', i, l.title, l.price);
        else
            fprintf('%d. %s - $%.2f\n   Description: %s\n', i, l.title, l.price, l.description);
        end
    end

    index = input('\nEnter the number of the listing to update: ');
    if index < 1 || index > length(user.myListings)
        fprintf('Invalid selection.\n');
        return;
    end

    if ismember(user.myListings(index).title, soldItems)
        fprintf('Cannot update a listing that has already been sold.\n');
        return;
    end

    title = input('Enter new title: ', 's');
    description = input('Enter new description: ', 's');
    price = input('Enter new price: ');

    user.myListings(index).title = title;
    user.myListings(index).description = description;
    user.myListings(index).price = price;

    if exist('listings.mat', 'file')
        load('listings.mat', 'allListings');
        for i = 1:length(allListings)
            if strcmp(allListings(i).sellerEmail, user.email) && strcmp(allListings(i).title, title)
                allListings(i) = user.myListings(index);
                break;
            end
        end
        save('listings.mat', 'allListings');
    end

    fprintf('Listing updated successfully.\n');
end
