%Contains all algorithms but main file of this contains code for print output of each algo on excel


%Algorithms = 'CS';
%Test_functions = 'Quartic';
Algorithms = [ 


'SBBO1  '; %Spiral BBO
'BBO    '; % biogeography-based optimization

]; 

Test_functions = [                
          'Ackley               ';
          'Alpine               ';
          'Quartic              ';
          'Rastrigin            ';
          'Rosenbrock           ';
          'PowellSum            ';
  ];
nFunction = size(Algorithms, 1);
nBench = size(Test_functions, 1);
MeanMin = zeros(nFunction, nBench);
BestMin = inf(nFunction, nBench);

for i=1:nFunction
    for j=1:nBench
        disp(['Optimization method ', num2str(i), '/', num2str(nFunction), ...
            ', Benchmark function ', num2str(j), '/', num2str(nBench)]);

 
        %generating sheets for convergence graph and boxpolts
        stre1=strcat(Test_functions(j,:),'_convergence','.xlsx');
        stre2=strcat(Test_functions(j,:),'_boxplot','.xlsx');
       
        % xlswrite(stre1,Algorithms',1,['A',num2str(2)]);
        DATA=(1:1001);
        xlswrite(stre1,DATA,1,['B',num2str(1)]);%,':','ALN',num2str(1)]);

        %xlswrite(stre2,Algorithms(:),1,['A',num2str(1)]);%,':','ALN',num2str(1)]);

        
        for k = 1:1:2
            tic;
            [Cost] = eval([Algorithms(i,:), '(@', Test_functions(j,:), ', false);']);
            if k == 1
%                 xlswrite(stre1,Cost,1,['B',num2str(i+1)]); %writing the data into each convergence sheet
                %xlswrite(stre1,Cost);
            end
            
%             MeanMin(i,j) = ((k - 1) * MeanMin(i,j) + Cost(end)) / k;
%             BestMin(i,j) = min(BestMin(i,j), Cost(end));
            standrd(k)= Cost(end);
%             btmean(k)=mean(Cost); 
                      
        end
        
        %writing data to Wilcoxon function test
        xlswrite(Test_functions(j,:),standrd,1,['B',num2str(i+1)]);
        
        % writing mean values of each montecalro in box plot sheet
%         xlswrite(stre2,btmean,1,['B',num2str(i+1)]);
%         stddev(i,j)=std(standrd); %standard devition for each algo on every benchmark
    end
end
%Write to excel
% xlswrite('MeanMin',MeanMin);
% xlswrite('BestMin',BestMin);
% xlswrite('standard deviation',stddev);