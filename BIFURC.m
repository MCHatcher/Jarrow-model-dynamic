% Jarrow dynamic bifurcation diagrams, July 2026. Case of one short-selling
% constrained asset (asset 2). Code written by M. Hatcher.

clear; clc;

%----------------------
%Specify belief types
%----------------------
%Parameter values
M = 60;  %No. of initial values 
window = 60;  %Sample to plot  
T = 990 + window;  %990 + window; 60
num_betta = 50; 
betta_min = 0; betta_max = 8;

%Bifurcation parameter
betta_stack1 = betta_min:0.25:5; betta_stack2 = linspace(max(betta_stack1)+ 0.0025,betta_max,num_betta);
betta_stack = [betta_stack1 betta_stack2];
%betta_stack = linspace(betta_min,betta_max,num_betta);
num_betta = length(betta_stack);  dev = NaN(num_betta,1); dum = dev;

%-----------------
%Dividend shocks
%-----------------
shock =  zeros(2,T);  %Deterministic skeleton

K = 100;           % No. of investors
J = 2;             % No. of markets
%T = 30;            % No. of periods

r = 0.01;             % Riskfree rate 
%betta = 0.975;        % Intensity of choice
dbar = 10;            % Expected dividend
D_bar = dbar*ones(J,1);   
N_bar = ones(J,1);  % Outside supplies

n_iter = 50;        % No. of price iterations
k_back = 0;         % No. of back steps
Iter = 1;           % Turn on price iterations
dum_slack = 0;      %0 = shorting ban; 1 = no shorting ban;

Investors = 1:K; dum_sol_t = zeros(T,1); slack_t = dum_sol_t; constrained_t = dum_sol_t; 
Demands1 = NaN(T,K); Demands2 = Demands1; Pop = Demands1; Check = NaN(T,1);
%Beliefs1 = Pop;  Beliefs2 = Pop;

%Covariance matrix
Var1 = 1; Var2 = 3; CV = -0.65*sqrt(Var1)*sqrt(Var2);  
Omega_bar = [Var1 CV;CV Var2];   %vcov matrix
V_bar = Omega_bar \ eye(2);
V11 = [det(V_bar)/V_bar(2,2) 0; 0 0];

Pf = ( D_bar - Omega_bar*N_bar )/r;  %Fundamental price vector

%Price beliefs
g = 0.8*ones(1,K) + linspace(0,0.272,K); C = zeros(1,K); %b = C; 
%b(1:round(K/2)) = linspace(-0.1,0.1,round(K/2));
g(1:round(K/2)) = linspace(0,0.2,round(K/2));  C(1:round(K/2)) = 1-g(1:round(K/2));

%----------------------
%Preallocate matrices
%----------------------
brk = zeros(M,1); percent = zeros(length(betta_stack),1); Check_fin = NaN(M,1); C1 = Check_fin; sd_x = Check_fin;
x1_stack = NaN(window,M); x2_stack = NaN(window,M); x1_plot = NaN(window*M,1); x2_plot = NaN(window*M,1);
%sd_plot1 = zeros(M,num_betta);

tic

for v=1:num_betta 
    
    betta = betta_stack(v);
    
for m = 1:M

%Initial price 
rng(m)
Ptild0 = [1+rand*2, 7+rand*2];

Jarrow_DYN_BIFURC

%Store value for bifurc diagram
x1_stack(1:window,m) = Ptild(1,T+1-window:T); 
x2_stack(1:window,m) = Ptild(2,T+1-window:T); 

%Check for no attractor
%r1 = 1-isreal(Ptild(1,T)); r2 = isnan(Ptild(1,T)); r3 = isinf(Ptild(1,T));

%-------------------------------
%Record sims with no attractor
%-------------------------------
if dummy>0
    brk(m) = 1;  
end

Check_fin(m) = max(Check);
C1(m) = max(constrained_t);
%sd_x(m) = std(x(end+1-50:end));

end

x1_plot(:,v) = reshape(x1_stack,1,[]);
x2_plot(:,v) = reshape(x2_stack,1,[]);
%sd_plot1(:,v) = sd_x;
%sd_plot1(:,v) = sd_plot1(:,v)./sd_plot(:,v);
%Uncomment after simulating Unconstrained = 0 to get relative SD for plot

dev(v) = max(Check_fin);
dum(v) = nnz(C1>0);

%Percentage of sims with no attractor
percent(v) = 100*sum(brk)/M;

end

%Accuracy checks
max_dev = max(dev)
%Check whether SS constraint binds in one or more sims
bind_no = max(dum)
per = percent;

%-----------------
% Plot results
%-----------------

figure(1)
subplot(1,2,1)
hold on,
xlabel('Intensity of choice \beta'), ylabel('Price deviation'), title('Asset 1')
axis([betta_min,betta_max,-inf,0.0001]), set(gca, 'box','on')
%axis([betta_min,betta_max,-inf,inf]), set(gca, 'box','on')
plot(betta_stack, x1_plot,'o', 'MarkerSize', 1.5, 'color',[0.5,0.5,0.5]) %[0.5,0.5,0.5], 'k', 2,1.5

subplot(1,2,2)
hold on,
xlabel('Intensity of choice \beta'), ylabel('Price deviation'), title('Asset 2')
axis([betta_min,betta_max,-inf,0.001]), set(gca, 'box','on')
%axis([betta_min,betta_max,-inf,inf]), set(gca, 'box','on')
plot(betta_stack, x2_plot,'o', 'MarkerSize', 1.5, 'color',[0.5,0.5,0.5]) %[0.5,0.5,0.5], 'k',  2,1.5

toc

%savefig("bifurcation.fig")
%exportgraphics(figure(1), 'bifurcation.pdf')
%saveas(gcf,'bifurcation.pdf')

%clear

