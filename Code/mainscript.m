function [] = mainscript(notread)
    % clear;
    if nargin < 1
        notread = 1;
    end
    
    if notread
        %load data
        load('S');
    else
        % uniprot_3d_20151008.tab.txt
        % 
        % read and generate unique keywords for each columns
        S = readuniprottab('uniprot_3d_20151008.tab.txt',0.8);
        
        % batch process keyset
%         dicts = structfun(@searchnumdict, S);
%         names = fieldnames(S);
%         for i=1:length(dicts)
%             S.(['SearchNumDict_' names(i)]) = dicts(i);
%         end
%         
% batch process keyset
%         dicts = structfun(@searchnumdict, S);
%         names = fieldnames(S);
%         for i=1:length(dicts)
%             S.(['SearchNumDict_' names(i)]) = dicts(i);
%         end

        names = fieldnames(S);
         names = {...
             %'Organism'
             'Cross_reference_PDB_'
             'Cross_reference_Pfam_'
             }
         
             
             
% 
%     'Entry'
%     'Sequence'
%     'EntryName'
%     'ProteinNames'
%     'Organism'
%     'GeneOntology_GO_'
%     'GeneOntologyIDs'
%     'GeneNames'
%     'TaxonomicLineage_ALL_'
%     'Annotation'
%     'Keywords'
%     'ProteinExistence'
%     'Cross_reference_PDB_'
%     'Cross_reference_Pfam_'
%     'TaxonomicLineage_all_'
%     'TaxonomicLineageIDs_all_'
%     'GeneOntology_molecularFunction_'
%     'Length'
%     'Mass'
%     'x3D'
%     'EntryIndexDict'
%     'SearchNumDict_Annotation'
        S.('SearchNumDict_Keywords') = searchnumdict(S.Keywords);
        save('SCross_Keywords.mat','S');

        S.('SearchNumDict_Cross_reference_PDB_') = searchnumdict(S.Cross_reference_PDB_);
        save('SCross_reference_PDB.mat','S');
        
        for i=1:length(names)
            namestr = char(names(i));
            if isempty(strfind(namestr, 'Entry')) && isempty(strfind(namestr, 'Seq')) ... 
                && isempty(strfind(namestr, 'Length'))  && isempty(strfind(namestr, 'Mass')) ...
                && isempty(strfind(namestr, 'Taxo')) 
                
                %if char(names(i))[1]
                varname = ['SearchNumDict_' char(names(i))];
                eval([varname '= searchnumdict(S.(char(names(i))));']);
                save([varname '.mat'],varname);
                clear(varname);
            end
            
            
        end

        % SearchNumDict_Annotation = searchnumdict(S.Annotation);
        

        %S.('SearchNumDict_Annotation') = searchnumdict(S.Annotation);
        %save('SAnnotation.mat','S');
        
    end
end

%% create keyset indclude cross keyset A B AB BA, and get their google count
function dict = searchnumdict(field)
    uniset = buildkeyset(field);
    len = length(uniset);
    index = len + 1;
    for i = 1:len
        for j = 1:len
            uniset(index) = {[char(uniset(i)) ' ' char(uniset(j))]};
            index = index + 1;
        end
    end
    dict = getsnumfor(uniset);
end

