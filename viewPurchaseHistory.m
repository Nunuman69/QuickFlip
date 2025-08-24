function viewPurchaseHistory(user)
    fprintf('\n=== Your Purchase History ===\n');
    if isempty(user.purchasedProducts)
        fprintf('You have not purchased anything yet.\n');
        return;
    end
    totalSpent = 0;
    for i = 1:length(user.purchasedProducts)
        p = user.purchasedProducts(i);
        fprintf('%d. %s - $%.2f\n   Description: %s\n   Seller: %s\n   Delivered to: %s\n   Date: %s\n\n', ...
            i, p.title, p.price, p.description, p.sellerName, p.address, p.date);
        totalSpent = totalSpent + p.price;
    end
    fprintf('Total Spent: $%.2f\n', totalSpent);
end
