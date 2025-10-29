%% input
T=1;
k_1=9.71;

A=[1 T; 0 1];
B=[T^2*k_1/2; T*k_1];
C=[1 0];
D=0;

%% a

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

%% b

G=1;
H=1;
B_eta=1;

barA=[G -B_eta*C;
      [0;0] A]
barB=[0;B]
barB1=[B_eta;[0;0]]

barU=[barB barA*barB barA^2*barB]
rank(barU)

barG=[0 1 0;
     0 0 1;
     0 0 0];
barH=[1 0 0];

cvx_begin sdp
variable barM(3,3)
barM*barG - barA*barM == -barB*barH;
cvx_end

barM
barK=barH*inv(barM)

barF=barA-barB*barK
eig(barF)

%% sim

barC=[0 C]
k1=barK(2);
bBg=barB1+k1*barB

set_param('sim3/barF', 'Gain', mat2str(barF));
set_param('sim3/barC', 'Gain', mat2str(barC));
set_param('sim3/barBg', 'Gain', mat2str(bBg));

%% L

Gn=[0 1;
    0 0];
Hn=[1 0];

cvx_begin sdp
variable Mn(2,2)
Mn*Gn-A'*Mn == -C'*Hn;
cvx_end

Mn
L = (Hn*Mn^-1)'

Fn=A-L*C
eig(Fn)

%% с (just use prev L)

% G=1;
% H=1;
% B_eta=1;
% 
% barA=[G -B_eta*C;
%       [0;0] A]
% barB=[0;B]
% barB1=[B_eta;[0;0]]
% 
% barGn=[0 1 0;
%        0 0 1;
%        0 0 0];
% barHn=[1 0 0];
% 
% barC=[1 C];
% 
% barV=[barC;barC*barA; barC*barA^2]
% rank(barV)
% 
% cvx_begin sdp
% variable barMn(3,3)
% barMn*barGn-barA'*barMn == -barC'*barHn;
% cvx_end
% 
% barMn
% L = (barHn*barMn^-1)'
% 
% barFn=barA-L*barC
% eig(barFn)