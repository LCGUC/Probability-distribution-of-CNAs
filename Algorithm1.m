clc; clear all;close all

%Data without sex chromosomes 
d= dir('C:\Users\user\Chromosomes\*.xlsx');


for i=1:length(d)
    
    fname=d(i).name;
    [num,txt,data] = xlsread(fname);
    
    %Define start and end vectors
    start = data(2:end,2);
    stop = data(2:end,3);
    
    %Creates identification vectors: 0 for starts and 1 for ends
    x =  num2cell(zeros(length(start),1));
    y =  num2cell(ones(length(stop),1));
    
    %Associates starts and ends to their respective id value
    start = [start,x];
    stop  = [stop,y];
    
   
    %Creates matrix length(Amp)x1, containing every value of start and stop
    limits = [start;stop];
    
    %Creates array containing the patients' names(x2 because they are
    %start+stop)
    
    patients = [data(2:end,4);data(2:end,4)];
    
    %Sort data in ascending order, by column 2 (start+stop)
   
    Dados = sortrows([patients,limits],[2]);
    
    %It sums up all the patients contained in each interval (
    % How many patients in each start (0) and so on until finding a
    % Stop (1)) 
    
    counts = zeros(length(Dados),1);
    counts(1)=1;
    
    start_a =[];
    start_a(1)=0;
    
    stop_a=[];
    size_a =[];
    
    cont=[];
    new=[];
 
    
    for j=2:length(Dados(:,3))
        
        if cell2mat(Dados(j,3))== 1 %when it's a stop
            counts(j) = counts(j-1)-1;
        else                                %when it's a start
            counts(j) = counts(j-1)+1;
        end
        
        if cell2mat(Dados(j,2))- cell2mat(Dados(j-1,2)) ~=0
            
            start_a(j,1)= cell2mat(Dados(j-1,2));
            stop_a(j,1) = cell2mat(Dados(j,2));
            
            size_a(j,1)= cell2mat(Dados(j,2))- cell2mat(Dados(j-1,2));
            cont(j,1) = counts(j-1);
            
        end
        
    end

    new = [start_a, stop_a,size_a,cont];
    
    new= new(new(:,1)~=0,:);
    
    max_data= max(new(:,4));
    
    min_reg = new(new(:,4)==max_data,:);
    
    [x1,~]= size(min_reg);
    
        col_header={'Start','Stop','Size','Num_patients'};
 
       if (~isempty(new))
          xlswrite(new);
          
       end
    
       
     

end
