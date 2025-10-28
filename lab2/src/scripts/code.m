T=1;
k_1=9.71;

A=[1 T; 0 1];
B=[T^2*k_1/2; T*k_1];
C=[1 0];
D=0;

eig(A)

U=[B A*B]
rank(U)

V=[C;C*A]
rank(V)

z1=0;
z2=0;
G=[z1 1; 0 z2];
H=[1 0];

V2=[H;H*G]
rank(V2)

cvx_begin sdp
variable M(2,2)
M*G-A*M == -B*H;
cvx_end

M
K = H*M^-1

F=A-B*K