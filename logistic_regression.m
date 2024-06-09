function [loss, weight] = logistic_regression(X,Y, tol, eta, weight_init, max_iter)
    sigmoid = @(z) 1 ./ (1 + exp(-z));
    N = size(X , 1);
    lost_fn = @(y, z) -y .* log(z) - (1 - y) .* log(1 - z);
    weight = weight_init;
    loss = [];
    cnt = 0;
    while(cnt < max_iter)
        rng(2);
        mix_id = randperm(N);
        for i = mix_id
            xi = X(i , :);
            yi = Y(i);
            zi = sigmoid(weight * xi');
            weight_new = weight + eta * (yi' - zi)*xi;
            z = sigmoid(weight * X');
            lose = mean(lost_fn(Y', z));
            loss = [loss ; lose];
            cnt = cnt + 1;
            if cnt >= max_iter || norm(weight_new - weight) < tol
                weight = weight_new;
                break;
            end
            weight = weight_new;
        end
    end
end

%This is the code that we use stochastic gradient descent, we can use mini
%batch gradient descent here or batch gradient descent follows our desire.