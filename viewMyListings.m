function user = viewMyListings(user)
    fprintf('\n=== Your Listings ===\n');
    if isempty(user.myListings)
        fprintf('You have not created any listings yet.\n');
        return;
    end
    for i = 1:length(user.myListings)
        listing = user.myListings(i);
        fprintf('%d. %s - $%.2f\n   Description: %s\n', ...
            i, listing.title, listing.price, listing.description);
    end
end
