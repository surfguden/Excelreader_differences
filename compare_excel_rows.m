function [] = compare_excel_rows(file_1,file_2,file_to_write)

    file_1='C:\Users\olaja\Downloads\Översikt_ESSF10_uppgifter_och_inlämningar 2023-03-24 11_22 (1).xlsx';  
    
    opts = detectImportOptions(file_1);
    for i=opts.VariableNames
        opts = setvartype(opts, i, 'char');
    end
     opts.PreserveVariableNames=true
    T = readtable(file_1,opts);

    file_2='C:\Users\olaja\Downloads\2023-04-18 14_13 (1).xlsx';
    opts = detectImportOptions(file_2);
    for i=opts.VariableNames
        opts = setvartype(opts, i, 'char');
    end
    opts.PreserveVariableNames=true
    T2 = readtable(file_2,opts);
%end
    t_new= [T; T2];



 [~, ia,ic]=unique(t_new,"rows");

dups=logical.empty();
for i=1:numel(ic)
    if sum(ic==ic(i))>=2
        dups(i)=true;
    else
        dups(i)=false;
    end
end
t_new(dups,:)=[];
t_new=sortrows(t_new);

dups=logical.empty();
[C, ia,ic]=unique(t_new.Personnummer);
for i=1:numel(ic)
    if sum(ic==ic(i))==2
        dups(i)=true;
    else
        dups(i)=false;
    end
end
singlets=~dups;
t_duplets=t_new(dups,:);
t_singlets=t_new(singlets,:);

%loop thruogh all variables excel first 5
%[unique_personnr,ia,ic]=unique(t_new.Personnummer)
for i = 1:2:height(t_duplets) 
    for j=6:width(t_duplets)
        if strcmp(t_duplets{i,j},t_duplets{i+1,j})==1
            t_duplets{i,j}={''};
            t_duplets{i+1,j}={''};        
        end
    end
end
t_to_write=[t_singlets ;t_duplets];

writetable(t_to_write,'C:\Users\olaja\Downloads\skillnader.xlsx')
end