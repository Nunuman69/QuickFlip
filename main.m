clc;
clear;

% Create user data folder if it doesn't exist
if ~exist('users', 'dir')
    mkdir('users');
end

fprintf('Welcome to the Second-Hand Marketplace!\n');

% === Login / Signup Menu Loop ===
while true
    % --- Ask Sign In or Sign Up ---
    while true
        choice = input('Do you want to:\n1. Sign In\n2. Sign Up\nChoose (1 or 2): ');
        if choice == 1 || choice == 2
            break;
        else
            fprintf('Invalid input. Please choose 1 to Sign In or 2 to Sign Up.\n');
        end
    end

    % --- Common Input ---
    email = input('Enter your email: ', 's');
    password = input('Enter your password: ', 's');
    safeEmail = replace(email, {'@', '.'}, {'_at_', '_dot_'});
    userFile = fullfile('users', [safeEmail '_data.mat']);

    loggedIn = false;

    % Sign In
    if choice == 1
        if exist(userFile, 'file')
            load(userFile, 'user');
            if strcmp(user.password, password)
                fprintf('Login successful. Welcome back, %s!\n\n', user.name);
                loggedIn = true;
            else
                fprintf('Incorrect password.\n');
            end
        else
            signupPrompt = input('No account found. Would you like to sign up? (y/n): ', 's');
            if strcmpi(signupPrompt, 'y')
                name = input('Enter your full name: ', 's');
                user.name = name;
                user.email = email;
                user.password = password;
                user.myListings = [];
                user.purchasedProducts = [];
                save(userFile, 'user');
                fprintf('Account created! Welcome, %s!\n\n', name);
                loggedIn = true;
            else
                fprintf('Returning to main menu...\n\n');
            end
        end
    else
        % Sign Up
        if exist(userFile, 'file')
            fprintf('An account already exists. Please sign in.\n');
        else
            name = input('Enter your full name: ', 's');
            dob = input('Enter your Date of Birth (dd-mm-yyyy): ', 's');
            phone = input('Enter your phone number: ', 's');
            
            user.dob = dob;
            user.phone = phone;
            user.preferences = struct('minPrice', [], 'maxPrice', [], 'location', '', 'category', '');
            user.name = name;
            user.email = email;
            user.password = password;
            user.myListings = [];
            user.purchasedProducts = [];
            save(userFile, 'user');
            fprintf('Account created successfully! Welcome, %s!\n\n', name);
            loggedIn = true;
        end
    end

    if loggedIn
        break;
    end
end

% === Main Menu ===
while true
    fprintf('\nHello %s, what do you want to do?\n', user.name);
    fprintf(' 1. View your current listings\n');
    fprintf(' 2. View purchase history\n');
    fprintf(' 3. Create a new listing\n');
    fprintf(' 4. Update a listing\n');
    fprintf(' 5. Remove a listing\n');
    fprintf(' 6. Search listings / Buy\n');
    fprintf(' 7. View items you sold\n');
    fprintf(' 8. View what others have bought\n');
    fprintf('-1. Logout / Exit\n');

    choice = input('Enter your choice: ');

    switch choice
        case 1
            user = viewMyListings(user);
        case 2
            viewPurchaseHistory(user);
        case 3
            user = createListing(user);
        case 4
            user = updateListing(user);
        case 5
            user = removeListing(user);
        case 6
            user = searchAndBuy(user);
        case 7
            viewSoldListings(user);
        case 8
            viewOthersPurchases(user);
        case -1
            save(userFile, 'user');
            fprintf('Goodbye, %s! Your data has been saved.\n', user.name);
            break;
        otherwise
            fprintf('Invalid choice. Try again.\n');
    end

    if choice == -1
        break;
    end
end
