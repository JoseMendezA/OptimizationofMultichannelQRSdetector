function [ Offspring, Rmut, Pm] = Mutacion( Offspring,iter,max_iter,I_alpha,I_beta)
    
    %Uncorrelated Mutation with two Step Sizes
    %The same distribution is used to mutate each xi, we only have one
    %strategy parameter \sigma in each individual. This \sigma is mutated
    %each time step by multipliying it by term exp(T), with T a random
    %variable drawn each time from a normal distribution with mean 0 and
    %standard deviation \sigma. Since N(0,sigma)= sigma*N(0,1), the
    %mutation mechanism is thus specified by sigma'= sigma*tao*N(0,1));
    %and xi'= xi + sigma'*Ni(0,1);
    
%   SHRINK controls how fast the SCALE is reduced as generations go by. A
%   SHRINK value of 0 will result in no shrinkage, yielding a constant
%   search size. A value of 1 will result in SCALE shrinking linearly to 0
%   as GA progresses to the number of generations specified by the options
%   structure.
        
    [Ro , Co] = size(Offspring);
    tao = 1/sqrt(2*Ro); %Learning Rate
    
    % Probability of mutation Pm
    np = Co; % the numbers of parameters
    Pm = (2 +((np-2)/(max_iter-1))*iter)^-1 % Back and Schutz 1996
    Rmut = rand
    shrink = 0.8; %The value for SHRINK is the default value SHRINK=0.75. 
    
    %  Do the mutation.
    
     if Rmut < Pm % Dinamic Probability mutation: Adapted during the learning phase
        irow = randperm(Ro);
        for i = 1: Ro
            iy = irow(i); % select individual 
            
            Ng_alpha = randn(); % N(0,1) from the standard normal distribution for alpha coefficients
            Ng_beta = randn(); % N(0,1) from the standard normal distribution for Beta decision threshold
            sigma_a = Offspring(iy,end-2); % Standard deviation for alpha coefficients
            sigma_b = Offspring(iy,end-1); % Standard deviation for Beta decision threshold 
            
            %N(0,sigma)= sigma*N(0,1)
            sigma_alpha = sigma_a*exp(tao*Ng_alpha); 
            sigma_alpha = sigma_alpha-sigma_alpha*shrink*(iter/max_iter); %controls what fraction of the gene's range is searched 
            sigma_beta = sigma_b*exp(tao*Ng_beta);
            sigma_beta = sigma_beta-sigma_beta*shrink*(iter/max_iter);
            
            % A boundary rule is applied to prevent standard deviation very close to
            % zero; is used to force step sizes to be no smaller than a
            % threshold: sigma'<epsilon => sigma'=epsilon
            lower = 0.0001;
            if sigma_alpha < lower
                sigma_alpha = lower;
            end

            if sigma_beta < lower
                sigma_beta = lower;
            end
            
               for ix = 1 : (Co-2) % Last 3 genes correspond to standard deviation (2 genes) and Beta decision threshold
                                        
                          %sigma'= sigma*exp(tao*N(0,1));
                          Ni = randn();    % Ni(0,1) Separate draw from the standard normal 
                                           % distribution for each variable i.
                          Offspring_temp(iy,ix)=Offspring(iy,ix)+sigma_alpha*Ni;
                          if (Offspring_temp(iy,ix) < I_alpha(1,2)) && ...
                              (Offspring_temp(iy,ix) > I_alpha(1,1)) % Upper and lower bounder for alpha coefficients
                              Offspring(iy,ix)=Offspring_temp(iy,ix); % Satisfies the constraints for alpha coefficients 
                          end
                              
                          
               end
               
               % mutate in range of standard and beta threshold
               for iz = (Co-1) : Co      % Last 2 genes correspond to standard deviation for Beta and Beta decision threshold
                          Nv = randn();  % Ni(0,1) Separate draw from the standard normal 
                                         % distribution for each variable i.
                          Offspring_temp(iy,iz)=Offspring(iy,iz)+sigma_beta*Nv;
                          if iz == Co-1 % Standar deviaton for betha trheshold
                              if (Offspring_temp(iy,iz) < I_beta(1,2)) && ...
                              (Offspring_temp(iy,iz) > 0) % Upper and lower bounder
                              Offspring(iy,iz)=Offspring_temp(iy,iz); % Satisfies the constraints for alpha coefficients 
                              end
                          else
                              if (Offspring_temp(iy,iz) < I_beta(1,2)) && ...
                                  (Offspring_temp(iy,iz) > I_beta(1,1)) % Upper and lower bounder for betha threshold 
                                  Offspring(iy,iz)=Offspring_temp(iy,iz); % Satisfies the constraints for alpha coefficients 
                              end
                          end
               end
        end
    end
   
end  
    
  