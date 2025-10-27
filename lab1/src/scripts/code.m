T=0.25;
A=[1 T; 0 1];
B=[T^2/2;T];
K=[105.0064 5.6742] % k1 k2

F=A-B*K

eigF = eig(F)

x0 = [1; 0];
N = 20;

x = zeros(length(x0), N+1);
x(:,1) = x0;

for k = 1:N
    x(:,k+1) = F * x(:,k);
end

time = (0:N)*T;

plot(time, x(1,:), '-o', 'LineWidth', 1.5); hold on;
plot(time, x(2,:), '-x', 'LineWidth', 1.5);
xlabel('k');
ylabel('x_k');
legend('x_1','x_2');

% title(sprintf('x_{k+1} = F x_k, eig(F) = {%0.2f, %0.2f}', eigF(1), eigF(2)));
title(sprintf('x_{k+1} = F x_k, eig(F) = {%0.2f + %0.2fi, %0.2f %0.2fi}', ...
    real(eigF(1)), imag(eigF(1)), real(eigF(2)), imag(eigF(2))));
grid on;