function [Gra_UT_k] = cal_gra_to_Lambda(k,lambda,Omega,Omega_eve)
%%%%%%%%%%%%%%%%%%%%%%%%%lambda  Nt*(Nu+1)
[Nr,Nt,Nu] = size(Omega);
[Ne,~] = size(Omega_eve);

Gra_UT_k = zeros(Nt,Nu+1);    %%%%%%%%%%% Nu+1 �ǵ�k���û���������� Nu+1 ��lambda��ƫ��
for lambda_i = 1:Nu+1           %%% UT_k����lambda_i��
    if lambda_i == k              %%% UT_k ���� lambda_k ��
        for m = 1:Nt
            temp = 0;
            for n = 1:Ne
                temp = temp + Omega_eve(n,m)/(1 + Omega_eve(n,:) * (lambda(:,k) + lambda(:,Nu+1)));
            end
            Gra_UT_k(m,lambda_i) = temp;
        end
        
    elseif lambda_i == Nu+1   %%% UT_k����lambda_eve��
        for m = 1:Nt
            temp_1 = 0;
            temp_2 = 0;
            for n = 1:Ne
                temp_1 = temp_1 + Omega_eve(n,m)/(1 + Omega_eve(n,:) * (lambda(:,k) + lambda(:,Nu+1)));
            end
            for n = 1:Nr
                lambda_cal = sum(lambda,2) - lambda(:,k);
                temp_2 = temp_2 + Omega(n,m,k)/(1 + Omega(n,:,k) * lambda_cal );
            end
            Gra_UT_k(m,lambda_i) = temp_1 + temp_2; 
        end
    else              %%lambda_i ~=k        %%% UT_k����lambda�� ����lambda_k �� lambda_eve 
        for m = 1:Nt
            temp = 0;
            for n = 1:Nr
                lambda_cal = sum(lambda,2) - lambda(:,k);
                temp = temp + Omega(n,m,k)/(1 + Omega(n,:,k) * lambda_cal );
            end
            Gra_UT_k(m,lambda_i) = temp;
        end
    end

end

end

