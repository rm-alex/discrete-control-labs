T=0.25;
A=[1 T; 0 1];
B=[T^2/2;T];
K=[0.1888 -2.4636] % k1 k2

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

stairs(time, x(1,:), 'LineWidth', 1.5);
% hold on;
% stairs(time, x(2,:), 'LineWidth', 1.5);
xlabel('t');
% ylabel('x_k');
% legend('x_1','x_2');
ylabel('y(t)')

title(sprintf('System output, eig(F) = {%0.2f, %0.2f}', eigF(1), eigF(2)));
% title(sprintf('System output, eig(F) = {%0.2f %0.2fi, %0.2f + %0.2fi}', ...
%     real(eigF(1)), imag(eigF(1)), real(eigF(2)), imag(eigF(2))));
grid on;